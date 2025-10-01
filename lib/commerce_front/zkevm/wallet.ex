defmodule ZkEvm.Wallet do
    @moduledoc false
    @secp256k1 :crypto.ec_curve(:secp256k1)
    import ExSha3
    @polygonscan_zkevm_api "https://api-zkevm.polygonscan.com/api"

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
      <<_::binary-size(1), raw::binary>> = pub   # drop 0x04 prefix
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

      request_polygonscan(params)
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
