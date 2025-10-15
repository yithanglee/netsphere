defmodule ZkEvm.Token do
    @moduledoc """
    ERC-20 utility module for zkEVM / Polygon in Elixir.
    Supports balance queries and token transfers.
    """

    alias Ethereumex.HttpClient
  @polygonscan_zkevm_api "https://api-zkevm.polygonscan.com/api"

    @erc20_abi [
      %{
        "constant" => true,
        "inputs" => [%{"name" => "_owner", "type" => "address"}],
        "name" => "balanceOf",
        "outputs" => [%{"name" => "balance", "type" => "uint256"}],
        "type" => "function"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{"name" => "_to", "type" => "address"},
          %{"name" => "_value", "type" => "uint256"}
        ],
        "name" => "transfer",
        "outputs" => [%{"name" => "success", "type" => "bool"}],
        "type" => "function"
      },
      %{
        "constant" => false,
        "inputs" => [
          %{"name" => "_spender", "type" => "address"},
          %{"name" => "_value", "type" => "uint256"}
        ],
        "name" => "approve",
        "outputs" => [%{"name" => "success", "type" => "bool"}],
        "type" => "function"
      },
      %{
        "constant" => true,
        "inputs" => [],
        "name" => "decimals",
        "outputs" => [%{"name" => "", "type" => "uint8"}],
        "type" => "function"
      }
    ]

    @doc """
    Get ERC-20 token balance for an address.
    """
    def balance_of(token_address, wallet_address) do
      data = encode_call(@erc20_abi, "balanceOf", [address_to_uint(wallet_address)])

      {:ok, result_hex} =
        HttpClient.eth_call(%{to: token_address, data: data}, "latest")

      decimals_hex = encode_call(@erc20_abi, "decimals", [])

      {:ok, decimals_result} =
        HttpClient.eth_call(%{to: token_address, data: decimals_hex}, "latest")

      decimals = hex_to_integer(decimals_result)
      raw_balance = hex_to_integer(result_hex)

      balance = raw_balance / :math.pow(10, decimals)

      %{raw: raw_balance, decimals: decimals, formatted: balance}
    end

    @doc """
    Transfer ERC-20 tokens from a wallet to a recipient.
    Requires private key of sender.
    returns a {:ok, transctionId }
    the transactionId is the polygon scan transation.
    """
    def transfer(token_address, privkey_hex, to_address, amount, decimals \\ 18) do
      privkey = Base.decode16!(String.replace_leading(privkey_hex, "0x", ""), case: :lower)

      {:ok, from_address} = privkey_to_address(privkey)

      # Encode transfer(to, value)
      value = trunc(amount * :math.pow(10, decimals))
      data = encode_call(@erc20_abi, "transfer", [address_to_uint(to_address), value])

      # Fetch nonce and chain id
      {:ok, nonce_hex} = HttpClient.eth_get_transaction_count(from_address, "latest")
      nonce = hex_to_integer(nonce_hex)
      {:ok, chain_id_hex} = HttpClient.eth_chain_id()
      chain_id = hex_to_integer(chain_id_hex)

      # Fetch gas price and estimate gas limit
      gas_price =
        case HttpClient.eth_gas_price() do
          {:ok, gp_hex} -> hex_to_integer(gp_hex)
          _ -> 30_000_000_000
        end

      gas_limit =
        case HttpClient.eth_estimate_gas(%{from: from_address, to: token_address, data: data}) do
          {:ok, gas_hex} -> hex_to_integer(gas_hex)
          _ -> 100_000
        end

      tx = %{
        nonce: nonce,
        gasPrice: gas_price,
        gas: gas_limit,
        to: token_address,
        value: 0,
        data: data,
        chainId: chain_id
      }

      signed = sign_transaction(tx, privkey)

      HttpClient.eth_send_raw_transaction("0x" <> Base.encode16(signed, case: :lower))
    end

    @doc """
    Approve ERC-20 allowance for a spender from the owner's wallet.
    Returns {:ok, tx_hash} on success.
    """
    def approve(token_address, privkey_hex, spender_address, amount, decimals \\ 18) do
      privkey = Base.decode16!(String.replace_leading(privkey_hex, "0x", ""), case: :lower)

      {:ok, from_address} = privkey_to_address(privkey)

      # Encode approve(spender, value)
      value = trunc(amount * :math.pow(10, decimals))
      data = encode_call(@erc20_abi, "approve", [address_to_uint(spender_address), value])

      # Fetch nonce and chain id
      {:ok, nonce_hex} = HttpClient.eth_get_transaction_count(from_address, "latest")
      nonce = hex_to_integer(nonce_hex)
      {:ok, chain_id_hex} = HttpClient.eth_chain_id()
      chain_id = hex_to_integer(chain_id_hex)

      # Fetch gas price and estimate gas limit
      gas_price =
        case HttpClient.eth_gas_price() do
          {:ok, gp_hex} -> hex_to_integer(gp_hex)
          _ -> 30_000_000_000
        end

      gas_limit =
        case HttpClient.eth_estimate_gas(%{from: from_address, to: token_address, data: data}) do
          {:ok, gas_hex} -> hex_to_integer(gas_hex)
          _ -> 100_000
        end

      tx = %{
        nonce: nonce,
        gasPrice: gas_price,
        gas: gas_limit,
        to: token_address,
        value: 0,
        data: data,
        chainId: chain_id
      }

      signed = sign_transaction(tx, privkey)

      HttpClient.eth_send_raw_transaction("0x" <> Base.encode16(signed, case: :lower))
    end

    ## Helpers

    @doc """
    Derive the sender address from a private key hex string.
    """
    def address_from_privkey_hex(privkey_hex) do
      privkey = Base.decode16!(String.replace_leading(privkey_hex, "0x", ""), case: :lower)
      {:ok, addr} = privkey_to_address(privkey)
      addr
    end

    defp privkey_to_address(priv) do
      pub =
        case :crypto.generate_key(:ecdh, :secp256k1, priv) do
          {public_key, _returned_priv} -> public_key
          public_key when is_binary(public_key) -> public_key
        end

      <<_prefix, raw::binary>> = pub
      hash = ExSha3.keccak_256(raw)
      addr = "0x" <> Base.encode16(binary_part(hash, 12, 20), case: :lower)
      {:ok, addr}
    end

    defp sign_transaction(tx, priv) do
      nonce_bin = int_to_bin(tx.nonce)
      gas_price_bin = int_to_bin(tx.gasPrice)
      gas_limit_bin = int_to_bin(tx.gas)
      to_bin = hex_to_bin_address(tx.to)
      value_bin = int_to_bin(Map.get(tx, :value, 0))
      data_bin = hex_to_bin(tx.data)

      chain_id_bin = int_to_bin(tx.chainId)

      signing_list = [
        nonce_bin,
        gas_price_bin,
        gas_limit_bin,
        to_bin,
        value_bin,
        data_bin,
        chain_id_bin,
        <<>>, # r
        <<>>  # s
      ]

      sighash = ExSha3.keccak_256(rlp_encode(signing_list))

      {:ok, {signature, recovery_id}} = ExSecp256k1.sign_compact(sighash, priv)
      <<r::binary-32, s::binary-32>> = signature

      v = tx.chainId * 2 + 35 + recovery_id

      final_list = [
        nonce_bin,
        gas_price_bin,
        gas_limit_bin,
        to_bin,
        value_bin,
        data_bin,
        int_to_bin(v),
        trim_leading_zeros(r),
        trim_leading_zeros(s)
      ]

      rlp_encode(final_list)
    end

    defp encode_call(abi_spec, function_name, args) do
      selector =
        abi_spec
        |> ABI.parse_specification()
        |> Enum.find(fn s -> s.type == :function and s.function == function_name end)

      data = ABI.encode(selector, args)
      "0x" <> Base.encode16(data, case: :lower)
    end

    defp hex_to_integer("0x" <> rest), do: String.to_integer(rest, 16)
    defp hex_to_integer(rest), do: String.to_integer(rest, 16)

    defp address_to_uint("0x" <> hex), do: String.to_integer(hex, 16)
    defp address_to_uint(val) when is_integer(val), do: val
    defp address_to_uint(hex) when is_binary(hex), do: String.to_integer(hex, 16)

    # === RLP helpers ===
    defp rlp_encode(item) when is_list(item) do
      encoded_items = Enum.map(item, &rlp_encode/1) |> IO.iodata_to_binary()
      prefix_list(encoded_items)
    end

    defp rlp_encode(item) when is_binary(item) do
      prefix_string(item)
    end

    defp prefix_string(<<>>) do
      <<0x80>>
    end

    defp prefix_string(<<single>>) when single < 0x80 do
      <<single>>
    end

    defp prefix_string(bin) when byte_size(bin) <= 55 do
      <<0x80 + byte_size(bin)>> <> bin
    end

    defp prefix_string(bin) do
      len_bytes = :binary.encode_unsigned(byte_size(bin))
      <<0xb7 + byte_size(len_bytes)>> <> len_bytes <> bin
    end

    defp prefix_list(encoded_items) when byte_size(encoded_items) <= 55 do
      <<0xc0 + byte_size(encoded_items)>> <> encoded_items
    end

    defp prefix_list(encoded_items) do
      len_bytes = :binary.encode_unsigned(byte_size(encoded_items))
      <<0xf7 + byte_size(len_bytes)>> <> len_bytes <> encoded_items
    end

    defp int_to_bin(0), do: <<>>
    defp int_to_bin(n) when is_integer(n) and n > 0, do: :binary.encode_unsigned(n)

    defp trim_leading_zeros(<<0, rest::binary>>), do: trim_leading_zeros(rest)
    defp trim_leading_zeros(<<>>), do: <<>>
    defp trim_leading_zeros(bin), do: bin

    defp hex_to_bin("0x" <> hex), do: hex_to_bin(hex)
    defp hex_to_bin(hex) when is_binary(hex) do
      norm = if rem(byte_size(hex), 2) == 1, do: "0" <> hex, else: hex
      Base.decode16!(norm, case: :mixed)
    end

    defp hex_to_bin_address(nil), do: <<>>
    defp hex_to_bin_address("0x" <> rest), do: hex_to_bin_address(rest)
    defp hex_to_bin_address(rest) when is_binary(rest) do
      bin = Base.decode16!(rest, case: :mixed)
      # ensure 20 bytes for an address
      case byte_size(bin) do
        20 -> bin
        _ -> raise "Invalid address length"
      end
    end
  @doc """
  Fetch ERC-20 transfer history for an address from Polygonscan (zkEVM).

  Options:
    - :contractaddress (filter by specific token contract)
    - :startblock (default 0)
    - :endblock (default 99_999_999)
    - :page (default 1)
    - :offset (default 100)
    - :sort ("asc" | "desc", default "desc")
  Returns {:ok, list} on success or {:error, reason}.
  """
  def token_transfer_history(address, api_key, opts \\ []) do
    base_params = %{
      module: "account",
      action: "tokentx",
      address: address,
      startblock: Keyword.get(opts, :startblock, 0),
      endblock: Keyword.get(opts, :endblock, 99_999_999),
      page: Keyword.get(opts, :page, 1),
      offset: Keyword.get(opts, :offset, 100),
      sort: Keyword.get(opts, :sort, "desc"),
      apikey: api_key
    }

    params =
      case Keyword.get(opts, :contractaddress) do
        nil -> base_params
        contract -> Map.put(base_params, :contractaddress, contract)
      end

    request_polygonscan(params)
  end

  defp request_polygonscan(params) do
    url = @polygonscan_zkevm_api <> "?" <> URI.encode_query(params)

    case :hackney.request(:get, url, [{"accept", "application/json"}], "", []) do
      {:ok, 200, _headers, client_ref} ->
        case :hackney.body(client_ref) do
          {:ok, body} ->
            case Jason.decode(body) do
              {:ok, %{"status" => "1", "result" => result}} -> {:ok, result}
              {:ok, %{"status" => "0", "message" => message, "result" => result}} ->
                {:error, {:polygonscan_error, message, result}}
              {:error, decode_err} -> {:error, {:decode_error, decode_err}}
              other -> {:error, {:unexpected_response, other}}
            end

          {:error, reason} -> {:error, {:http_body_error, reason}}
        end

      {:ok, status, _headers, client_ref} ->
        _ = :hackney.body(client_ref)
        {:error, {:http_status, status}}

      {:error, reason} ->
        {:error, {:http_error, reason}}
    end
  end
end
