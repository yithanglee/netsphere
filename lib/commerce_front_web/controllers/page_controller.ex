defmodule CommerceFrontWeb.PageController do
  use CommerceFrontWeb, :controller

  def index(conn, _params) do
    IO.inspect("it's reloading!")
    render(conn, "index.html")
  end

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def pdf_preview(conn, %{"id" => id, "type" => "do"} = params) do
    sale = CommerceFront.Settings.get_sale!(id)

    conn
    |> render("do_pdf.html",
      title: "Delivery Order",
      sale: sale,
      order_lines: sale.sales_items,
      layout: {CommerceFrontWeb.LayoutView, "blank.html"}
    )
  end

  def pdf(conn, %{"id" => id, "type" => "do"} = params) do
    sale = CommerceFront.Settings.get_sale!(id)

    server_url = Application.get_env(:commerce_front, :url)
    server_url = "http://localhost:4000"

    html =
      Phoenix.View.render_to_string(
        CommerceFrontWeb.PageView,
        "do_pdf.html",
        conn: conn,
        title: "Delivery Order",
        sale: sale,
        order_lines: sale.sales_items
      )
      |> String.replace("/images", "#{server_url}/images")

    IO.inspect(server_url)

    css = "<link rel='stylesheet' href='#{server_url}/css/app.css' >
        <link rel='stylesheet' href='#{server_url}/css/all.css' >"

    pdf_params = %{
      "html" => "<!DOCTYPE html><html><head>#{css}</head><body>#{html}</body></html>"
    }

    IO.puts(pdf_params["html"])

    pdf_binary =
      PdfGenerator.generate_binary!(
        pdf_params["html"],
        size: "A4",
        shell_params: [
          "--page-width",
          "100cm",
          "--margin-left",
          "5",
          "--margin-right",
          "5",
          "--margin-top",
          "5",
          "--margin-bottom",
          "5",
          "--encoding",
          "utf-8",
          "--orientation",
          "Portrait"
        ],
        delete_temporary: true
      )

    conn
    |> put_resp_content_type("application/pdf")
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=\"DeliveryOrder_#{params["id"]}.pdf\""
    )
    |> send_resp(200, pdf_binary)
  end

  def pdf_preview(conn, %{"id" => id} = params) do
    sale = CommerceFront.Settings.get_sale!(id)

    conn
    |> render("co_pdf.html",
      title: "Customer Order",
      sale: sale,
      order_lines: sale.sales_items,
      layout: {CommerceFrontWeb.LayoutView, "blank.html"}
    )
  end

  def pdf(conn, %{"id" => id} = params) do
    sale = CommerceFront.Settings.get_sale!(id)

    server_url = Application.get_env(:commerce_front, :url)
    server_url = "http://localhost:4000"

    html =
      Phoenix.View.render_to_string(
        CommerceFrontWeb.PageView,
        "co_pdf.html",
        conn: conn,
        title: "Customer Order",
        sale: sale,
        order_lines: sale.sales_items
      )
      |> String.replace("/images", "#{server_url}/images")

    IO.inspect(server_url)

    css = "<link rel='stylesheet' href='#{server_url}/css/app.css' >
        <link rel='stylesheet' href='#{server_url}/css/all.css' >"

    pdf_params = %{
      "html" => "<!DOCTYPE html><html><head>#{css}</head><body>#{html}</body></html>"
    }

    IO.puts(pdf_params["html"])

    pdf_binary =
      PdfGenerator.generate_binary!(
        pdf_params["html"],
        size: "A4",
        shell_params: [
          "--page-width",
          "100cm",
          "--margin-left",
          "5",
          "--margin-right",
          "5",
          "--margin-top",
          "5",
          "--margin-bottom",
          "5",
          "--encoding",
          "utf-8",
          "--orientation",
          "Portrait"
        ],
        delete_temporary: true
      )

    conn
    |> put_resp_content_type("application/pdf")
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=\"CustomerOrder_#{params["id"]}.pdf\""
    )
    |> send_resp(200, pdf_binary)
  end

  def authenticate(conn, params) do
    case check_password(params) do
      {true, user} ->
        conn
        |> put_session(:current_user, BluePotion.s_to_map(user))
        |> redirect(to: "/home")

      _ ->
        conn
        |> redirect(to: "/login")
    end
  end

  def check_password(params) do
    # your auth method here

    user = CommerceFront.Settings.get_user_by_username(params["username"])

    if user != nil do
      crypted_password =
        :crypto.hash(:sha512, params["password"]) |> Base.encode16() |> String.downcase()

      {crypted_password == user.crypted_password, user}
    else
      false
    end
  end

  def thank_you(conn, params) do
    IO.inspect("it's reloading!")
    render(conn, "thank_you.html", params)
  end
end
