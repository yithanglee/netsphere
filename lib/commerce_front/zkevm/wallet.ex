defmodule ZkEvm.Wallet do
  @moduledoc false
  @secp256k1 :crypto.ec_curve(:secp256k1)
  import ExSha3
  @polygonscan_zkevm_api "https://api-zkevm.polygonscan.com/api"
  @etherscan_v2_api "https://api.etherscan.io/v2/api"

  # Generate a random private key
  def generate_private_key do
    :crypto.strong_rand_bytes(32)
  end

  # Derive public key
  def private_to_public(priv) do
    case :crypto.generate_key(:ecdh, @secp256k1, priv) do
      {pub, _returned_priv} -> pub
      pub when is_binary(pub) -> pub
    end
  end

  # Convert public key → Ethereum/zkEVM address
  def public_to_address(pub) do
    # drop 0x04 prefix
    <<_::binary-size(1), raw::binary>> = pub
    hash = ExSha3.keccak_256(raw)
    "0x" <> Base.encode16(binary_part(hash, 12, 20), case: :lower)
  end

  def generate_wallet do
    priv = generate_private_key()
    pub = private_to_public(priv)
    addr = public_to_address(pub)

    %{
      private_key: "0x" <> Base.encode16(priv, case: :lower),
      public_key: "0x" <> Base.encode16(pub, case: :lower),
      address: addr
    }
  end

  @doc """
  Fetch normal transaction history for a wallet address from Polygonscan (zkEVM).

  Options:
    - :startblock (default 0)
    - :endblock (default 99_999_999)
    - :page (default 1)
    - :offset (default 100)
    - :sort ("asc" | "desc", default "desc")
  Returns {:ok, list} on success or {:error, reason}.
  """
  def tx_history(address, api_key, opts \\ []) do
    params = %{
      module: "account",
      action: "txlist",
      address: address,
      startblock: Keyword.get(opts, :startblock, 0),
      endblock: Keyword.get(opts, :endblock, 99_999_999),
      page: Keyword.get(opts, :page, 1),
      offset: Keyword.get(opts, :offset, 100),
      sort: Keyword.get(opts, :sort, "desc"),
      apikey: api_key
    }

    request_explorer(params, opts)
  end

  @doc """
  Fetch internal transaction history for a wallet address from Polygonscan (zkEVM).

  Same options as `tx_history/3`.
  Returns {:ok, list} on success or {:error, reason}.
  """
  def internal_tx_history(address, api_key, opts \\ []) do
    params = %{
      module: "account",
      action: "txlistinternal",
      address: address,
      startblock: Keyword.get(opts, :startblock, 0),
      endblock: Keyword.get(opts, :endblock, 99_999_999),
      page: Keyword.get(opts, :page, 1),
      offset: Keyword.get(opts, :offset, 100),
      sort: Keyword.get(opts, :sort, "desc"),
      apikey: api_key
    }

    request_explorer(params, opts)
  end

  @doc """
  Fetch ERC-20 token transfer history for a wallet address.

  Options:
    - :contractaddress (optional, filter to a specific token contract)
    - :startblock (default 0)
    - :endblock (default 99_999_999)
    - :page (default 1)
    - :offset (default 100)
    - :sort ("asc" | "desc", default "desc")
    - plus provider/chainid when using Etherscan V2
  """
  def token_transfers(address, api_key, opts \\ []) do
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

    params = put_optional_params(base_params, opts, [:contractaddress])
    request_explorer(params, opts)
  end

  @doc """
  Fetch event logs via Polygonscan (zkEVM) Logs API.

  Accepts address and optional topics/operators per Etherscan/Polygonscan spec:
    - :fromBlock (default 0)
    - :toBlock (default 99_999_999)
    - :page (default 1)
    - :offset (default 1000)
    - :topic0, :topic1, :topic2, :topic3
    - :topic0_1_opr, :topic1_2_opr, :topic2_3_opr, :topic0_2_opr, :topic0_3_opr, :topic1_3_opr

  Returns {:ok, list} or {:ok, []} when no records are found.
  """
  def logs_by_address(address, api_key, opts \\ []) do
    base_params = %{
      module: "logs",
      action: "getLogs",
      address: address,
      fromBlock: Keyword.get(opts, :fromBlock, 0),
      toBlock: Keyword.get(opts, :toBlock, 99_999_999),
      page: Keyword.get(opts, :page, 1),
      offset: Keyword.get(opts, :offset, 1000),
      apikey: api_key
    }

    optional_keys = [
      :topic0,
      :topic1,
      :topic2,
      :topic3,
      :topic0_1_opr,
      :topic1_2_opr,
      :topic2_3_opr,
      :topic0_2_opr,
      :topic0_3_opr,
      :topic1_3_opr
    ]

    params = put_optional_params(base_params, opts, optional_keys)
    request_explorer(params, opts)
  end

  defp put_optional_params(params, opts, keys) do
    Enum.reduce(keys, params, fn key, acc ->
      case Keyword.fetch(opts, key) do
        {:ok, value} when not is_nil(value) and value !== "" ->
          Map.put(acc, Atom.to_string(key), value)

        _ ->
          acc
      end
    end)
  end

  defp request_explorer(params, opts \\ []) do
    provider = Keyword.get(opts, :provider, :etherscan_v2)

    params =
      case provider do
        :etherscan_v2 ->
          case Keyword.get(opts, :chainid) do
            nil -> params
            chainid -> Map.put(params, :chainid, chainid)
          end

        _ ->
          params
      end

    url =
      case provider do
        :etherscan_v2 ->
          @etherscan_v2_api <> "?" <> URI.encode_query(params)

        _ ->
          @polygonscan_zkevm_api <> "?" <> URI.encode_query(params)
      end

    case :hackney.request(:get, url, [{"accept", "application/json"}], "", []) |> IO.inspect() do
      {:ok, 200, _headers, client_ref} ->
        case :hackney.body(client_ref) do
          {:ok, body} ->
            case Jason.decode(body) do
              {:ok, %{"status" => "1", "result" => result}} ->
                {:ok, result}

              {:ok, %{"status" => "0", "message" => message, "result" => result}}
              when message in ["No transactions found", "No records found"] or result == [] or
                     result in ["No transactions found", "No records found"] ->
                {:ok, []}

              {:ok, %{"status" => "0", "message" => message, "result" => result}} ->
                {:error, {:polygonscan_error, message, result}}

              {:error, decode_err} ->
                {:error, {:decode_error, decode_err}}

              other ->
                {:error, {:unexpected_response, other}}
            end

          {:error, reason} ->
            {:error, {:http_body_error, reason}}
        end

      {:ok, status, _headers, client_ref} ->
        _ = :hackney.body(client_ref)
        {:error, {:http_status, status}}

      {:error, reason} ->
        {:error, {:http_error, reason}}
    end
  end
end
