Application.put_env(:ethereumex, :url, System.get_env("RPC") || "https://polygon-rpc.com")
Application.ensure_all_started(:logger)
Application.ensure_all_started(:telemetry)
Application.ensure_all_started(:crypto)
Application.ensure_all_started(:ssl)
Application.ensure_all_started(:public_key)
Application.ensure_all_started(:inets)
Application.ensure_all_started(:castore)
Application.ensure_all_started(:hpax)
Application.ensure_all_started(:mint)
Application.ensure_all_started(:nimble_options)
Application.ensure_all_started(:nimble_pool)
Application.ensure_all_started(:finch)
Application.ensure_all_started(:ex_keccak)
Application.ensure_all_started(:ex_sha3)
Application.ensure_all_started(:ex_abi)
Application.ensure_all_started(:ethereumex)
Code.compile_file("lib/commerce_front/zkevm/token.ex")

IO.inspect(
  ZkEvm.Token.balance_of(
    "0xa17C6FC7D9EcEf353CeB3132DdD619037D134125",
    "0x9ae4a34345d433034e6e89fc77918ab2039684a9"
  )
)
