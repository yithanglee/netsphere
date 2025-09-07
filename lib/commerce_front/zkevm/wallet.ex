defmodule ZkEvm.Wallet do
    @moduledoc false
    @secp256k1 :crypto.ec_curve(:secp256k1)
    import ExSha3
  
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
  end
  