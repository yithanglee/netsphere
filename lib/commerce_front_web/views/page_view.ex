defmodule CommerceFrontWeb.PageView do
  use CommerceFrontWeb, :view

  def format_currency(nil), do: "RM 0.00"

  def format_currency(value) when is_binary(value) do
    case Decimal.parse(value) do
      {decimal, ""} -> format_currency(decimal)
      _ -> "RM 0.00"
    end
  end

  def format_currency(value) do
    if value != 0 do
      float_value = value
      whole_part = trunc(float_value)

      decimal_part =
        :erlang.float_to_binary(float_value - whole_part, decimals: 2) |> String.slice(1..-1)

      formatted_whole =
        whole_part
        |> Integer.to_string()
        |> String.reverse()
        |> String.replace(~r/(\d{3})(?=.)/, "\\1,")
        |> String.reverse()

      "RM #{formatted_whole}#{decimal_part}"
    else
      "RM 0.00"
    end
  end
end

defmodule CommerceFrontWeb.EmailView do
  use CommerceFrontWeb, :view
end
