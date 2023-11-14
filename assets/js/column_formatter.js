export let ColumnFormater = {
  datetime(row, dtdata, dataSource) {
    var dCols =
      dataSource.columns.filter((v, i) => {
        return v.formatDateTime == true;
      })
    dCols.forEach((v, i) => {
      var offset = v.offset
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data;
        })
      try {
        var str = dtdata[v.data]
        str = Date.parse(str)
        var dt = new Date(str)
        dt.setTime(dt.getTime() + ((8 + offset) * 60 * 60 * 1000));
        var edate = dt.toGMTString().split(",")[1].split(" ").splice(0, 4).join(" ")
        var etime = dt.toLocaleTimeString()


        $("td:eq(" + index + ")", row).html(
          `<span class="text-muted fw-bold">` + edate + `</span>

          <small class="fw-bold text-primary">
              ` + etime + `          
          </small>
             `);
        // }
      } catch (e) {
        console.log(e)

      }
    })
  },
  custom(row, dtdata, dataSource) {
    var showChildCols =
      dataSource.columns.filter((v, i) => {
        return v.customized == true;
      })
    showChildCols.forEach((v, i) => {
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data && x.xdata == v.xdata;
        })
      try {




        $("td:eq(" + index + ")", row).html(v.xdata.formatFn(dtdata));




      } catch (e) {

        console.log(e)


      }
    })

  },
  img(row, dtdata, dataSource) {
    var showBooleanCols =
      dataSource.columns.filter((v, i) => {
        return v.showImg == true;
      })
    showBooleanCols.forEach((v, i) => {
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data;
        })
      try {
        var ic;
        ic = `

        <div style="

background-size: contain !important; background-image: url('` + dtdata[v.data] + `') !important; 
        height: 80px;width: 80px;
background-position: center;
background-repeat: no-repeat;
" class="text-center 
        bg-white d-flex align-items-center justify-content-center text-white">
        </div>`
        $("td:eq(" + index + ")", row).html(ic);
      } catch (e) {

      }
    })
  },
  progress(row, dtdata, dataSource) {

    var showProgressCols =
      dataSource.columns.filter((v, i) => {
        return v.showProgress == true;
      })
    showProgressCols.forEach((v, i) => {
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data;
        })
      try {
        var content = dtdata[v.data];
        var progressList = v.progress;
        // populate the list
        var pg = []
        var perc = 1 / progressList.length * 100
        var check_index = progressList.findIndex((v, i) => { return v == content });
        progressList.forEach((progress, pi) => {
          if (check_index >= pi) {
            var bar = `<div class="progress-bar bg-warning " role="progressbar" style="width: ` + perc + `%;" ></div>
              `
          } else {
            var bar = `<div class="progress-bar " role="progressbar" style="width: ` + perc + `%;" ></div>
              `
          }
          pg.push(bar)
        })

        p = `
          <small>` + content + `</small>
          <div class="progress gap-1">
          ` + pg.join("") + `
          </div>
        `
        $("td:eq(" + index + ")", row).html(p);
      } catch (e) {

      }
    })

  },
  subtitle(row, dtdata, dataSource) {
    var showSubtitleCols =
      dataSource.columns.filter((v, i) => {
        return v.showSubtitle == true;
      })
    showSubtitleCols.forEach((v, i) => {
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data;
        })

      var subindex = 0
      subindex =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.subtitle;
        })
      try {
        var content = dtdata[v.data];
        var sub = dtdata[v.subtitle]

        if (dataSource.columns[index].showChild) {
          content = dtdata[v.xdata.child][v.xdata.data]
        }

        if (dataSource.columns[index].formatFloat) {
          content = currencyFormat(content)
        }
        if (dataSource.columns[subindex].formatFloat) {
          sub = currencyFormat(sub)
        }
        if (dataSource.columns[subindex].showBoolean) {
          if (dtdata[v.subtitle] == true) {
            sub = `<i class="text-success fa fa-check"></i>`
          } else {
            sub = `<i class="text-danger fa fa-times"></i>`
          }
        }

        $("td:eq(" + index + ")", row).html(`<span class="pe-2">` + content + `</span>
          <small class="text-muted text-truncate" style="max-width: 24vw;display: block;">` + sub + `</small>`);
      } catch (e) {

      }
    })
  },
  bool(row, dtdata, dataSource) {
    var showBooleanCols =
      dataSource.columns.filter((v, i) => {
        return v.showBoolean == true;
      })
    showBooleanCols.forEach((v, i) => {
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data;
        })
      try {
        var ic;
        if (dtdata[v.data] == true) {
          ic = `<i class="text-success fa fa-check"></i>`
        } else {
          ic = `<i class="text-danger fa fa-times"></i>`
        }
        $("td:eq(" + index + ")", row).html(ic);
      } catch (e) {

      }
    })
  },
  json(row, dtdata, dataSource) {
    var showJsonCols =
      dataSource.columns.filter((v, i) => {
        return v.showJson == true;
      })
    showJsonCols.forEach((v, i) => {
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data;
        })
      try {
        $("td:eq(" + index + ")", row).html(`<div aria-data='` + `` + `' class="jsv` + dataSource.makeid.id + `" id="` + v.data + `` + dtdata.id + `"></div>`);
      } catch (e) {

      }
    })
  },
  child(row, dtdata, dataSource) {
    var showChildCols =
      dataSource.columns.filter((v, i) => {
        return v.showChild == true;
      })
    showChildCols.forEach((v, i) => {
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data && x.xdata == v.xdata;
        })
      try {
        $("td:eq(" + index + ")", row).html(dtdata[v.xdata.child][v.xdata.data]);

        if (v.xdata.showImg) {
          try {
            console.log("attemp to show img...")
            if (dtdata[v.xdata.child][0] != null) {
              var ic;
              ic = `
              <div style="background-size: cover !important; background-image: url('` + dtdata[v.xdata.child][0][v.xdata.data] + `') !important; 
              height: 80px;width: 80px" class="rounded-circle text-center 
              bg-primary d-flex align-items-center justify-content-center text-white">
              </div>`
              $("td:eq(" + index + ")", row).html(ic);
            }
          } catch (e) {

          }
        }
        if (v.xdata.formatFloat) {
          $("td:eq(" + index + ")", row).html(currencyFormatdtdata[v.xdata.child][v.xdata.data]);
        }

      } catch (e) {


      }
    })
  },

  float(row, dtdata, dataSource) {
    var formatFloatCols =
      dataSource.columns.filter((v, i) => {
        return v.formatFloat == true;
      })
    formatFloatCols.forEach((v, i) => {
      var index = 0
      index =
        dataSource.columns.findIndex((x, i) => {
          return x.data == v.data;
        })
      try {
        $("td:eq(" + index + ")", row).html(currencyFormat(dtdata[v.data]));
      } catch (e) {

      }
    })

  },
  dataFormatter(dtdata, v) {
    var input2 = null;
    var formatType = ['formatFloat', 'showBoolean', 'formatDateTime', 'showImg', 'showChild']
    var selectedKey = -1
    var keys = Object.keys(v)
    formatType.forEach((f, ii) => {
      if (keys.indexOf(f) > 0) {
        selectedKey = ii
      }
    })

    console.log(formatType[selectedKey])
    switch (formatType[selectedKey]) {
      case 'formatFloat':
        input2 = currencyFormat(dtdata[v.data]);
        break;
      case 'showImg':
        try {
          console.log(("simmg"))
          input2 = `
        <div style="background-size: cover !important; background-image: url('` + dtdata[v.data] + `') !important; 
        height: 80px;width: 80px" class="rounded-circle text-center 
        bg-primary d-flex align-items-center justify-content-center text-white">
        </div>`

        } catch (e) {
          console.log(e)

        }
        break;
      case 'showChild':
        try {
          input2 = dtdata[v.xdata.child][v.xdata.data]
          if (v.xdata.showImg) {
            try {
              console.log("attemp to show img...")
              if (dtdata[v.xdata.child][0] != null) {
                input2 = `
                <div style="background-size: cover !important; background-image: url('` + dtdata[v.xdata.child][0][v.xdata.data] + `') !important; 
                height: 80px;width: 80px" class="rounded-circle text-center 
                bg-primary d-flex align-items-center justify-content-center text-white">
                </div>`
              }
            } catch (e) {

            }
          }
          if (v.xdata.formatFloat) {
            input2 = currencyFormat(dtdata[v.xdata.child][v.xdata.data])
          }

        } catch (e) {

        }

        break;
      case 'showBoolean':
        try {
          var ic;
          if (dtdata[v.data] == true) {
            ic = `<i class="text-success fa fa-check"></i>`
          } else {
            ic = `<i class="text-danger fa fa-times"></i>`
          }
          input2 = ic
        } catch (e) {

        }
        break;

      case 'formatDateTime':
        // code block
        var str = dtdata[v.data]
        str = Date.parse(str)
        var dt = new Date(str)
        dt.setTime(dt.getTime() + (8 * 60 * 60 * 1000));
        var edate = dt.toGMTString().split(",")[1].split(" ").splice(0, 4).join(" ")
        var etime = dt.toLocaleTimeString()
        input2 = `<span class="text-muted fw-bold">` + edate + `</span>

              <small class="fw-bold text-primary">
                  ` + etime + `          
              </small>
                 `
        break;
      default:
        input2 = dtdata[v.data]
    }


    if (input2 == null) {
      input2 = dtdata[v.data]
    }

    return input2

  },
  formatDate() {
    $(" .format-int").each((i, v) => {
      var prefix = ""
      if ($(v).html().split(" ").includes("DR")) {
        prefix = "DR"
      }
      if ($(v).html().split(" ").includes("CR")) {
        prefix = "CR"
      }
      var content = $(v).html().replace("-", "")

      if (parseFloat(content) > 0) {
        var span = `<span class="text-end" >` + this.currencyFormat(parseFloat(content)).replace(".00", "") + ` ` + prefix + `</span>`
        $(v).html(span)

      } else if (parseFloat(content) == 0) {
        $(v).html("0.00")
      } else {
        $(v).html(content)
      }

    })
    $(".format_float, .format-float").each((i, v) => {
      var prefix = ""
      if ($(v).html().split(" ").includes("DR")) {
        prefix = "DR"
      }
      if ($(v).html().split(" ").includes("CR")) {
        prefix = "CR"
      }
      var content = $(v).html().replace("-", "")

      if (parseFloat(content) > 0) {
        var span = `<span class="text-end" >` + this.currencyFormat(parseFloat(content)) + ` ` + prefix + `</span>`
        $(v).html(span)

      } else if (parseFloat(content) == 0) {
        $(v).html("0.00")
      } else {
        $(v).html(content)
      }

    })

    $(".format_date").each((i, v) => {
      // console.log() 
      var d = $(v).html();
      if (Date.parse(d) > 0) {
        var date = new Date(d)
        var day;
        if (date.getDate().toString().length > 1) {
          day = date.getDate()
        } else {
          day = "0" + date.getDate()
        }
        var month;
        if ((date.getMonth() + 1).toString().length > 1) {
          month = (date.getMonth() + 1)
        } else {
          month = "0" + (date.getMonth() + 1)
        }

        $(v).html("<b>" + day + "-" + month + "-" + date.getFullYear() + "</b>")
      } else {
        $(v).html(d)

      }

    })
    $(".format_datetime").each((i, v) => {


      var offset = 0
      if ($(v).attr("aria-offset") != null) {

        offset = parseInt($(v).attr("aria-offset"))
      }

      // console.log() 
      var d = $(v).html();
      if (Date.parse(d.split(" ")[0]) > 0) {
        var date = new Date(d.split(" ")[0])
        var day;
        if (date.getDate().toString().length > 1) {
          day = date.getDate()
        } else {
          day = "0" + date.getDate()
        }
        var month;
        if ((date.getMonth() + 1).toString().length > 1) {
          month = (date.getMonth() + 1)
        } else {
          month = "0" + (date.getMonth() + 1)
        }

        var dt = new Date(d)
        dt.setTime(dt.getTime() + (8 * 60 * 60 * 1000));
        var edate = dt.toGMTString().split(",")[1].split(" ").splice(0, 4).join(" ")
        var etime = dt.toLocaleTimeString()


        $(v).html(`` + edate + ` ` + etime + ``)
      }

    })

    $(".is_posted").each((i, v) => {

      // console.log() 
      var d = $(v).html();
      if (d == "true") {
        $(v).html(`
                <i class="text-success fa fa-check"></i>
                `)
      }

      if (d == "false") {
        $(v).html(`
                <i class="text-danger fa fa-exclamation-circle"></i>
                `)
      }


    })
  },
  currencyFormat(num) {
    if (num == null) {

      return "0.00"
    } else {
      return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
    }
  },
  capitalize(string) {
    return string.replace(/^\w/, c => c.toUpperCase());
  }
}