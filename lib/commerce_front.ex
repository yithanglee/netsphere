defmodule CommerceFront do
  @moduledoc """
  CommerceFront keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def test_carry_forward() do
    CommerceFront.Settings.reconstruct_daily_group_sales_summary(~D[2023-11-07])
    CommerceFront.Settings.carry_forward_entry(~D[2023-11-07])
    CommerceFront.Settings.reconstruct_daily_group_sales_summary(~D[2023-11-08])
    CommerceFront.Settings.carry_forward_entry(~D[2023-11-08])
    CommerceFront.Settings.reconstruct_daily_group_sales_summary(~D[2023-11-09])
    CommerceFront.Settings.carry_forward_entry(~D[2023-11-09])

    CommerceFront.Settings.reconstruct_daily_group_sales_summary(~D[2023-11-10])
    CommerceFront.Settings.carry_forward_entry(~D[2023-11-10])
  end

  def test() do
    CommerceFront.Settings.reset()

    samples = [
      {"admin", "damien"},
      {"damien", "summer"},
      {"summer", "elis"},
      {"elis", "orange"},
      {"orange", "kathy"}
    ]

    samples = [
      {"admin", "damien", 1},
      {"damien", "summer", 3},
      {"damien", "elis", 2},
      {"damien", "orange", 1},
      {"damien", "kathy", 2},
      {"summer", "sm1", 1},
      {"summer", "sm2", 3},
      {"summer", "sm3", 1},
      {"summer", "sm4", 3},
      {"elis", "lsm1", 1},
      {"elis", "lsm2", 2},
      {"elis", "lsm3", 3},
      {"elis", "lsm4", 3},
      {"lsm1", "alsm1", 1},
      {"lsm1", "alsm2", 1},
      {"lsm1", "alsm3", 3},
      {"lsm1", "alsm4", 3},
      {"summer", "bsm1", 1},
      {"summer", "bsm2", 3},
      {"summer", "bsm3", 1},
      {"summer", "bsm4", 3}
    ]

    for {sponsor, username, rank_id} = sample <- samples do
      params =
        %{
          "email" => "a@1.com",
          "fullname" => "1",
          "password" => "abc123",
          "phone" => "60122664254",
          "rank_id" => rank_id,
          "sponsor" => sponsor,
          "username" => username
        }
        |> IO.inspect()

      CommerceFront.Settings.register(params)
    end
  end

  def get_order() do
    pid = Process.whereis(:rest_1)
    Agent.get(pid, fn x -> x end)
  end

  def add_order() do
    pid = Process.whereis(:rest_1)

    Agent.update(pid, fn list -> List.insert_at(list, 0, %{items: [%{name: "apple", qty: 1}]}) end)
  end

  def write_json(bin, filename) do
    check = File.exists?(File.cwd!() <> "/media")

    path =
      if check do
        File.cwd!() <> "/media"
      else
        File.mkdir(File.cwd!() <> "/media")
        File.cwd!() <> "/media"
      end

    File.rm_rf("./priv/static/images/uploads")
    File.ln_s("#{File.cwd!()}/media/", "./priv/static/images/uploads")

    File.rm_rf("#{path}/#{filename}")
    File.touch("#{path}/#{filename}")

    IO.inspect("writing into... #{path} #{filename}")

    File.write("#{path}/#{filename}", bin)
  end

  def eval_codes(singular, plural) do
    struct =
      singular |> String.split("_") |> Enum.map(&(&1 |> String.capitalize())) |> Enum.join("")

    dynamic_code =
      """
        alias CommerceFront.Settings.#{struct}
        def list_#{plural}() do
          Repo.all(#{struct})
        end
        def get_#{singular}!(id) do
          Repo.get!(#{struct}, id)
        end
        def create_#{singular}(params \\\\ %{}) do
          #{struct}.changeset(%#{struct}{}, params) |> Repo.insert() |> IO.inspect()
        end
        def update_#{singular}(model, params) do
          #{struct}.changeset(model, params) |> Repo.update() |> IO.inspect()
        end
        def delete_#{singular}(%#{struct}{} = model) do
          Repo.delete(model)
        end

        random_id = makeid(4)
        #{singular}Source = new phoenixModel({
          columns: [
          
            { label: 'id', data: 'id' },
            { label: 'Action', data: 'id' }

          ],
          moduleName: "#{struct}",
          link: "#{struct}",
          customCols: customCols,
          buttons: [{
            buttonType: "grouped",
            name: "Manage",
            color: "outline-warning",
            buttonList: [

              {
                name: "Edit",
                iconName: "fa fa-edit",
                color: "btn-sm btn-outline-warning",
                onClickFunction: editData,
                fnParams: {
                  drawFn: enlargeModal,
                  customCols: customCols
                }
              },
              {
                name: "Delete",
                iconName: "fa fa-trash",
                color: "outline-danger",
                onClickFunction: deleteData,
                fnParams: {}
              }
            ],
            fnParams: {

            }
            }, ],
          tableSelector: "#" + random_id
        })
        #{singular}Source.load(random_id, "#tab1")



          function call#{struct}() {
            #{singular}Source2 = new phoenixModel({
              columns: [{
                  label: 'Name',
                  data: 'name'
                },
                {
                  label: 'Action',
                  data: 'id'
                }
              ],
              moduleName: "#{struct}",
              link: "#{struct}",
              buttons: [{
                name: "Select",
                iconName: "fa fa-check",
                color: "btn-sm btn-outline-success",
                onClickFunction: (params) => {
                  var dt = params.dataSource;
                  var table = dt.table;
                  var data = table.data()[params.index]
                  console.log(data.id)
                  $("input[name='Book[#{singular}][name]']").val(data.name)
                  $("input[name='Book[#{singular}][id]']").val(data.id)
                  $("input[name='Book[#{singular}_id]']").val(data.id)
                  $("#myModal").modal('hide')
                },
                fnParams: {
                 
                }
              }, ],
              tableSelector: "#" + random_id
            })
            App.modal({
              selector: "#myModal",
              autoClose: false,
              header: "Search #{struct}",
              content: `
              <div id="#{singular}">

              </div>`
            })
            #{singular}Source2.load(makeid(4), '##{singular}')
            #{singular}Source2.table.on("draw", function() {
              if ($("#search_user").length == 0) {
                $(".module_buttons").prepend(`
                  <label class="col-form-label " for="inputSmall">#{struct} </label>
                  <input class="mx-4 form-control form-control-sm" id="search_user"></input>
                            `)
              }
              $('input#search_user').on('change', function(e) {
                var query = $(this).val()
                #{singular}Source2.table
                  .columns(0)
                  .search(query)
                  .draw();
              })
            })
          }




      """
      |> IO.puts()
  end

  def upload_file(params) do
    check_upload =
      Map.values(params)
      |> Enum.with_index()
      |> Enum.filter(fn x -> is_map(elem(x, 0)) end)
      |> Enum.filter(fn x -> :__struct__ in Map.keys(elem(x, 0)) end)
      |> Enum.filter(fn x -> elem(x, 0).__struct__ == Plug.Upload end)

    # Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)

    if check_upload != [] do
      upload_fn = fn check_upload_item, xparams ->
        file_plug = check_upload_item |> elem(0)
        index = check_upload_item |> elem(1)

        check = File.exists?(File.cwd!() <> "/media")

        path =
          if check do
            File.cwd!() <> "/media"
          else
            File.mkdir(File.cwd!() <> "/media")
            File.cwd!() <> "/media"
          end

        final =
          if is_map(file_plug) do
            IO.inspect(is_map(file_plug))
            fl = String.replace(file_plug.filename, "'", "")
            File.cp(file_plug.path, path <> "/#{fl}")
            "/images/uploads/#{fl}"
          else
            "/images/uploads/#{file_plug}"
          end

        Map.put(xparams, Enum.at(Map.keys(xparams), index), final)
      end

      Enum.reduce(check_upload, params, fn x, acc -> upload_fn.(x, acc) end)

      # for check_upload_item <- check_upload do
      # end
    else
      params
    end
  end
end
