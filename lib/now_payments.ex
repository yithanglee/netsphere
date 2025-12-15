defmodule NowPayments do
  require Logger

  @endpoint (Application.get_env(:commerce_front, :nowpayments) || %{})[:endpoint] ||
              "https://api.nowpayments.io"
  @api_key (Application.get_env(:commerce_front, :nowpayments) || %{})[:api_key]
  @price_currency (Application.get_env(:commerce_front, :nowpayments) || %{})[:price_currency] ||
                    "USD"

  @doc """
  Create an invoice on NOWPayments for a given reference and amount.

  opts can include:
  - :pay_currency (default: "USDT")
  - :pay_chain (default: "polygon")
  """
  def create_invoice(reference_no, amount, opts \\ %{}) do
    server_url = Application.get_env(:commerce_front, :url) || ""

    callback =
      (Application.get_env(:commerce_front, :nowpayments) || %{})[:callback] ||
        "#{server_url}api/payment/nowpayments"

    success_url =
      (Application.get_env(:commerce_front, :nowpayments) || %{})[:success_url] ||
        "#{server_url}thank_you"

    cancel_url =
      (Application.get_env(:commerce_front, :nowpayments) || %{})[:cancel_url] ||
        server_url

    pay_currency = opts |> Map.get(:pay_currency, "USDTMATIC")

    # pay_chain = opts |> Map.get(:pay_chain, "polygon") |> to_string()

    price_amount =
      case Application.get_env(:commerce_front, :release) do
        :prod -> amount
        _ -> amount
      end

    payload = %{
      "price_amount" => to_decimal_string(price_amount),
      "price_currency" => @price_currency,
      "pay_currency" => pay_currency,
      "order_id" => reference_no,
      "order_description" => "Order #{reference_no}",
      "ipn_callback_url" => callback,
      "success_url" => success_url,
      "cancel_url" => cancel_url
    }

    headers = [
      {"x-api-key", @api_key || ""},
      {"Content-Type", "application/json"}
    ]

    url = "#{@endpoint}/v1/invoice"

    case HTTPoison.post(url, Jason.encode!(payload), headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        with {:ok, res} <- Jason.decode(body) do
          %{
            status: :ok,
            invoice_id: res["id"] || res["invoice_id"],
            url: res["invoice_url"],
            raw: res
          }
        else
          _ -> %{status: :error, reason: :invalid_response}
        end

      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        Logger.error("NowPayments create invoice failed: #{code} #{body}")
        %{status: :error, reason: :http_error, code: code}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("NowPayments HTTP error: #{inspect(reason)}")
        %{status: :error, reason: reason}
    end
  end

  @doc """
  Create a payment on NOWPayments for a given reference and amount.

  opts can include:
  - :pay_currency (default: "USDTMATIC")
  - :origin_ip (customer IP, required for fiat2crypto)
  """
  def create_payment(reference_no, amount, opts \\ %{}) do
    server_url = Application.get_env(:commerce_front, :url) || ""

    callback =
      (Application.get_env(:commerce_front, :nowpayments) || %{})[:callback] ||
        "#{server_url}api/payment/nowpayments"

    success_url =
      (Application.get_env(:commerce_front, :nowpayments) || %{})[:success_url] ||
        "#{server_url}thank_you"

    cancel_url =
      (Application.get_env(:commerce_front, :nowpayments) || %{})[:cancel_url] ||
        server_url

    pay_currency = opts |> Map.get(:pay_currency, "USDTMATIC")

    price_amount =
      case Application.get_env(:commerce_front, :release) do
        :prod -> amount
        _ -> amount
      end

    payload = %{
      "price_amount" => to_decimal_string(price_amount),
      "price_currency" => @price_currency,
      "pay_currency" => pay_currency,
      "order_id" => reference_no,
      "order_description" => "Order #{reference_no}",
      "ipn_callback_url" => callback,
      "success_url" => success_url,
      "cancel_url" => cancel_url
    }

    headers =
      [
        {"x-api-key", @api_key || ""},
        {"Content-Type", "application/json"}
      ] ++
        case Map.get(opts, :origin_ip) do
          nil -> []
          "" -> []
          ip -> [{"origin-ip", ip}]
        end

    url = "#{@endpoint}/v1/payment"

    case HTTPoison.post(url, Jason.encode!(payload), headers) |> IO.inspect() do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        with {:ok, res} <- Jason.decode(body) do
          %{
            status: :ok,
            payment_id: res["payment_id"] || res["id"],
            payment_status: res["payment_status"],
            pay_amount: res["pay_amount"],
            pay_currency: res["pay_currency"],
            pay_address: res["pay_address"],
            raw: res
          }
        else
          _ -> %{status: :error, reason: :invalid_response}
        end

      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        Logger.error("NowPayments create payment failed: #{code} #{body}")
        %{status: :error, reason: :http_error, code: code}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("NowPayments HTTP error: #{inspect(reason)}")
        %{status: :error, reason: reason}
    end
  end

  @doc """
  Create a payment for an existing invoice.

  Required:
  - invoice_id (iid)

  opts can include:
  - :pay_currency (e.g. "btc")
  - :purchase_id (integer/string)
  - :order_description
  - :customer_email
  - :payout_address
  - :payout_extra_id
  - :payout_currency (e.g. "usdttrc20")
  - :origin_ip (customer IP, for fiat2crypto)
  """
  def create_invoice_payment(invoice_id, opts \\ %{}) do
    headers =
      [
        {"x-api-key", @api_key || ""},
        {"Content-Type", "application/json"}
      ] ++
        case Map.get(opts, :origin_ip) do
          nil -> []
          "" -> []
          ip -> [{"origin-ip", ip}]
        end

    base_payload = %{
      "iid" => invoice_id,
      "pay_currency" => Map.get(opts, :pay_currency, "USDTMATIC"),
      "purchase_id" => Map.get(opts, :purchase_id),
      "order_description" => Map.get(opts, :order_description),
      "customer_email" => Map.get(opts, :customer_email),
      "payout_address" => Map.get(opts, :payout_address),
      "payout_extra_id" => Map.get(opts, :payout_extra_id),
      "payout_currency" => Map.get(opts, :payout_currency)
    }

    payload =
      base_payload
      |> Enum.reject(fn {_k, v} -> is_nil(v) end)
      |> Enum.into(%{})

    url = "#{@endpoint}/v1/invoice-payment"

    case HTTPoison.post(url, Jason.encode!(payload), headers) |> IO.inspect() do
      {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
        with {:ok, res} <- Jason.decode(body) do
          %{
            status: :ok,
            payment_id: res["payment_id"] || res["id"],
            payment_status: res["payment_status"],
            raw: res
          }
        else
          _ -> %{status: :error, reason: :invalid_response}
        end

      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        Logger.error("NowPayments create invoice payment failed: #{code} #{body}")
        %{status: :error, reason: :http_error, code: code}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("NowPayments HTTP error: #{inspect(reason)}")
        %{status: :error, reason: reason}
    end
  end

  @doc """
  Get NOWPayments payment status by payment_id.

  Example: GET /v1/payment/:payment_id
  """
  def get_payment_status(payment_id) do
    headers = [
      {"x-api-key", @api_key || ""},
      {"Content-Type", "application/json"}
    ]

    url = "#{@endpoint}/v1/payment/#{payment_id}"

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        with {:ok, res} <- Jason.decode(body) do
          %{
            status: :ok,
            payment_status: res["payment_status"],
            raw: res
          }
        else
          _ -> %{status: :error, reason: :invalid_response}
        end

      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        Logger.error("NowPayments get payment status failed: #{code} #{body}")
        %{status: :error, reason: :http_error, code: code}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("NowPayments HTTP error: #{inspect(reason)}")
        %{status: :error, reason: reason}
    end
  end

  defp to_decimal_string(val) when is_binary(val), do: val

  defp to_decimal_string(val) when is_integer(val),
    do: :erlang.float_to_binary(val * 1.0, decimals: 2)

  defp to_decimal_string(val) when is_float(val),
    do: :erlang.float_to_binary(val, decimals: 2)

  defp to_decimal_string(val), do: "#{val}"
end
