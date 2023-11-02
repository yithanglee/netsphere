import { phxApp_ } from './phx_app.js';
import {
  ColumnFormater
} from './column_formatter.js';
export class phoenixModel {

  constructor(options) {
    var default_options = {
      moduleName: "User",
      link: "users",
      tableSelector: "#users",
      data: {},
      allData: [],
      buttons: [],
      tableButtons: [],
      table: null,
      columns: [],
      customCols: null,
      aliasName: null,
      onDrawFn: null,
      makeid: {},
      xcard: null

    }

    var keys =
      Object.keys(default_options)
    keys.forEach((v, i) => {
      this[v] = default_options[v]
    })
    keys.forEach((v, i) => {
      if (options[v] != null) {
        this[v] = options[v]
      }
    })

    var phxData = this.data;

    function loadDefaultGrid(object) {
      $(object.tableSelector).closest(".dataTables_wrapper").find(".grid_view .xc").each((ti, tv) => {
        var data = tv.data
        console.log("xcard..")
        if (object.xcard != null) {
          var res = object.xcard(data);
          $(tv).prepend(res)

        } else {
          var cols = []
          object.columns.forEach((v, i) => {
            var col = `
             <div class="d-flex flex-column pb-2" role="grid_data" aria-label="` + v.label + 
             `"><label class="fw-light">` + v.label + `</label>` + ColumnFormater.dataFormatter(data, v) + `</div>`
            cols.push(col)
          })

          var div = document.createElement("div")
          div.className = " card"
          div.innerHTML = cols.join("")
          console.log("ts")
          console.log(div)

          $(tv).prepend(div)
        }

      })
    }


    this.load = function(makeid, dom) {
      if (makeid != null) {
        this.tableSelector = "#" + makeid
        this.makeid = { id: makeid, dom: dom }
        phxApp_.Page.createTable(makeid, dom)
      } else {
        phxApp_.Page.createTable(this.makeid.id, this.makeid.dom)
      }
      phxApp_.populateTable(this)
      this.table.on('draw', () => {

        // <---- this function used to populate the grid view button ---->
        $(this.tableSelector).closest(".table-responsive").find(".module_buttons").html(`
        <div class="d-flex align-items-center">
          <div class="dropdown morphing scale-left ">
                     <a href="#" class="more-icon dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-h"></i></a>
                      <ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow border-0">
                        <li><a class="dropdown-item" href="javascript:void(0);" onclick="toggleView('` + this.tableSelector + `')">Grid View<i class="fa fa-th-large"></i></a></li>
                        <li><a class="dropdown-item" href="javascript:void(0);" onclick="App.Functions.reinit()">Reload<i class="fa fa-repeat"></i></a></li>
                        <li><a class="dropdown-item" href="javascript:void(0);" data-href="" data-module="add_new" data-ref="">New
                        <i class="fa fa-arrow-right"></i></a></li>
                      </ul>
                    </div>
        </div>

                `)

        var nbutton = $(this.tableSelector).closest(".table-responsive").find(".module_buttons [data-module='add_new']");
        try {
          if (nbutton.length > 0) {
            var ts = this.tableSelector
            nbutton[0].onclick = function() {
              window.currentSelector = ts
              form_new(ts, phxData)
            }
          }
        } catch (e) {}
        // <---- this function used to populate the table button ---->
        this.tableButtons.forEach((b, i) => {
          var buttonz = new formButton({
              iconName: b.iconName,
              color: b.color,
              name: b.name
            },
            b.fnParams,
            b.onClickFunction);
          $(this.tableSelector).closest(".table-responsive").find(".module_buttons").prepend(buttonz)
        })
        // <---- this function used to populate the grid view button ---->

        if (this.onDrawFn != null) {
          this.onDrawFn();
        }
        phxApp_.populateGridView(this)
        loadDefaultGrid(this)



      })
      this.table.on('page', () => {
        // the prev page is meant for restoring the pagination after update...
        try {
          window.prev_page = this.table.page()
        } catch (e) {}

      })

    };

    this.reload = function() {
      var id = this.tableSelector.split("#")[1]
      var html = `
                <table class="table"  style="width: 100%;" id="` + id + `">
                    <thead></thead>
                    <tbody></tbody>
                </table>
          `
      // here will destroy all the datatable elements and reinsert a new 1
      $(this.tableSelector).closest(".table-responsive").html(html)
      // when populate table ... not sure if the data is passed along..
      console.log("reload dt")
      phxApp_.populateTable(this)
      try {
        this.table.on('draw', () => {


          // <---- this function used to populate the grid view button ---->
          $(this.tableSelector).closest(".table-responsive").find(".module_buttons").html(`
        <div class="d-flex align-items-center">
          <div class="dropdown morphing scale-left ">
                     <a href="#" class="more-icon dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-h"></i></a>
                      <ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow border-0">
                        <li><a class="dropdown-item" href="javascript:void(0);" onclick="toggleView('` + this.tableSelector + `')">Grid View<i class="fa fa-th-large"></i></a></li>
                        <li><a class="dropdown-item" href="javascript:void(0);" onclick="App.Functions.reinit()">Reload<i class="fa fa-repeat"></i></a></li>
                        <li><a class="dropdown-item" href="javascript:void(0);" data-href="" data-module="add_new" data-ref="">New<i class="fa fa-arrow-right"></i></a></li>
                      </ul>
                    </div>
        </div>

           `)

          var nbutton = $(this.tableSelector).closest(".table-responsive").find(".module_buttons [data-module='add_new']");
          try {
            console.log("dt table data")
            console.log(this.data)
            console.log(nbutton)
            if (nbutton.length > 0) {
              var ts = this.tableSelector
              nbutton[0].onclick = function() {
                window.currentSelector = ts
                form_new(ts, phxData)
              }
            }
          } catch (e) {}

          // <---- this function used to populate the table button ---->
          this.tableButtons.forEach((b, i) => {
            var buttonz = new formButton({
                iconName: b.iconName,
                color: b.color,
                name: b.name
              },
              b.fnParams,
              b.onClickFunction);
            $(this.tableSelector).closest(".table-responsive").find(".module_buttons").prepend(buttonz)
          })

          // <---- this function used to populate the grid view button ---->

          if (this.onDrawFn != null) {
            this.onDrawFn();
          }
          phxApp_.populateGridView(this)
          loadDefaultGrid(this)

        })
        this.table.on('init', () => {
          // the prev page is meant for restoring the pagination after update...
          try {
            this.table.page(prev_page).draw('page')
          } catch (e) {}

        })
        this.table.on('page', () => {
          // the prev page is meant for restoring the pagination after update...
          try {
            window.prev_page = this.table.page()
          } catch (e) {}

        })

      } catch (e) {
        console.log(e)
      }

    };

  }



}