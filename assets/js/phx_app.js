import { commerceApp_ } from './commerce_app.js';
import { memberApp_ } from './member_app.js';
export let phxApp_ = {
  route_names: [
    { html: "landing.html", title: "Home", route: "/home" },


  ],
  ping() {

    console.log("tell ping o")
  },
  evalTitle(label) {

    if (localStorage.getItem("default-lang") == "cn") {

      switch (label.replace(" ", "")) {
        case "Home":
          label = "首页"
          break;
        case "Profile":
          label = "个人"
          break;
        case "Upgrade":
          label = "升级"
          break;
        case "Restocks":
          label = "朴货"
          break;
        case "Registrations":
          label = "审核"
          break;
        case "Sales":
          label = "业绩"
          break;
        case "Commissions":
          label = "佣金"
          break;
        default:
          label = label

      }
    }


    return label
  },
  navigateTo(route, additionalParamString) {
  
    if (route == null) {
      route = window.location.pathname
    }
    var current_pattern = route.split("/").filter((v, i) => {
      return v != "";
    })
    console.log(current_pattern)

    var match_1 = this.route_names.filter((rroute, i) => {
      var z = rroute.route.split("/").filter((v, i) => {
        return v != "";
      })
      console.log(z[z.length - 1])

      if (z[z.length - 1].includes(":")) {
        return z.length == current_pattern.length
      } else {

        return z.length == current_pattern.length && z[z.length - 1] == current_pattern[z.length - 1];
      }
    })

    var match_2 =
      match_1.filter((rroute, i) => {
        console.log(rroute)
        var z = rroute.route.split("/").filter((v, i) => {
          return v != "";
        })
        return z[0] == current_pattern[0]
      })
    this.hide()
    this.show()
    if (match_2.length > 0) {

      var params = {}
      match_2.forEach((rroute, i) => {
        var z = rroute.route.split("/").forEach((v, ii) => {
          if (v.includes(":")) {
            params[v.replace(":", "")] = current_pattern[ii - 1]
          }
        })
      })
      console.log("params here")
      console.log(params)
      window.pageParams = params
      var xParamString = ""
      if (additionalParamString == null) {
        xParamString = ""
      } else {
        xParamString = additionalParamString
      }

      if (window.back) {
        window.back = false
      } else {
        var stateObj = { fn: `navigateTo('` + route + `', '` + xParamString + `')`, params: params };
        console.log("xparams")
        console.log(xParamString)
        console.log("route")
        console.log(route)
        window.stateObj = stateObj
        window.matchTitle = match_2[0].title
        window.matchRoute = route


        if (Object.keys(params).includes("title")) {
          $("title").html(this.evalTitle(params.title))
          history.pushState(stateObj, evalTitle(params.title), route);
        } else {
          $("title").html(this.evalTitle(match_2[0].title))
          history.pushState(stateObj, this.evalTitle(match_2[0].title), route);
        }
      }
      var footer_modals = this.html("footer_modals.html")
      var html = this.html(match_2[0].html)
      var initPage = `
      <div class="page-content pb-0">
        ` + html + `
    
      </div>
        ` + footer_modals + `
          `
      var keys = Object.keys(match_2[0])
      if (keys.includes("skipNav")) {
        $("#content").html(initPage)
        this.navigateCallback()

      } else {
        var nav = this.html("blog_nav.html")
        if (keys.includes("customNav")) {
          var nav = this.html(match_2[0].customNav)
        }
        $("#content").html(nav)
        $("#content").append(initPage)
        this.navigateCallback()
      }
      return match_2[0]
    } else {
      var footer_modals = this.html("footer_modals.html")
      var html = this.html("landing.html")
      var initPage = `
      <div class="page-content pb-0">
        ` + html + `
      </div>        ` + footer_modals + ``
      $("#content").html(initPage)
      this.navigateCallback()

    }
  },
  modal(options) {

    var default_options = {
      selector: "#myModal",
      body: ".modal-body",
      title: ".modal-title",
      foot: ".modal-footer",
      header: "Modal Header",
      content: "Here is content for modal body",
      footer: "",
      drawFn: regularModal,
      autoClose: true

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
    $(this.selector).find(this.title).html(this.header)
    $(this.selector).find(this.body).html(this.content)
    $(this.selector).find(this.foot).html(this.footer)
    $(this.selector).modal("show")

    this.drawFn();
    if (this.autoClose) {
      setTimeout(() => {
        $(this.selector).modal("hide")
      }, 5000);
    }
  },
  toast(options) {
    var default_options = {
      selector: "#notification-1",
      body: ".toast-body",
      title: ".tbody",
      foot: ".modal-footer",
      header: "Modal Header",
      content: "Here is content for modal body",
      footer: "",
      drawFn: () => {},
      autoClose: true
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



    $(this.selector).find(this.title).html(this.header)
    $(this.selector).find(this.body).html(this.content)
    $(this.selector).toast('hide')
    $(this.selector).toast('show')
    this.drawFn();
    if (this.autoClose) {
      setTimeout(() => {
        $(this.selector).toast('hide')
      }, 15000);
    }



    // if (typeof stValidate === "function") {


    // }
  },
  notify(message, options) {
    if (options == null) {
      options = {}
    }

    var default_options = {
      delay: 2000,
      type: "info"
    }
    var keys = Object.keys(default_options)
    keys.forEach((v, i) => {
      this[v] = default_options[v]
    })
    keys.forEach((v, i) => {
      if (options[v] != null) {
        this[v] = options[v]
      }
    })


    var obj = {}
    var message_obj = {}

    if (typeof message == 'object') {
      message_obj = message
    } else {
      message_obj = {
        message: message
      }
    }

    var default_obj = {
      message: "Your text here",
      title: "System Message:",
      icon: "fa fa-exclamation-circle"
    }

    var keys = Object.keys(default_obj)
    keys.forEach((v, i) => {
      obj[v] = default_obj[v]
    })
    keys.forEach((v, i) => {
      if (message_obj[v] != null) {
        obj[v] = message_obj[v]
      }
    })
    console.log(obj)
    console.log(this)
    try {
      if (typeof $.notify === "function") {
        $.notify(obj, options)

      } else {

        this.toast({ content: obj.message, header: obj.title })
      }

    } catch (e) {
      this.toast({ content: obj.message, header: obj.title })
    }


  },
  reflect(formData) {
    var object = {};
    formData.forEach((value, key) => {

      console.log(key)
      var childMap = {}

      if (key.includes("\[")) {
        console.log("has child")
        var parent = key.split("\[")[0]
        var child = key.split("\[")[1].split("\]")[0]
        childMap[child] = value;
        object[parent] = { ...object[parent], ...childMap };

      } else {
        // Reflect.has in favor of: object.hasOwnProperty(key)
        if (!Reflect.has(object, key)) {
          object[key] = value;
          return;
        }
        if (!Array.isArray(object[key])) {
          object[key] = [object[key]];
        }
        object[key].push(value);
      }

    });
    return object;
  },
  validateForm(selector, successCallback) {
    var failed_inputs =
      $(selector).find("[name]").filter((i, v) => {
        console.log("checking vaidity")
        console.log(v)
        return v.checkValidity() == false
      })
    console.log(failed_inputs);
    if (failed_inputs.length > 0) {
      var labels = []
      failed_inputs.map((v, i) => {
        $(i).addClass("not-valid")
        var label = $(i).closest('.input-style').find("label div").html()
        if (label == null) {
          label = $(i).attr("name")
        }

        labels.push(label)



      })
      phxApp_.notify("This input: " + labels.join(", ") + " is not valid!", {
        type: "danger"
      });
    } else {
      successCallback()

    }
  },
  form(dom, scope, successCallback, failedCallback, appendMap) {
    phxApp_.show()
    var formData = new FormData($(dom)[0])
    formData.append("scope", scope)
    if (appendMap != null) {

      var keys = Object.keys(appendMap)

      keys.forEach((k, i) => {
        formData.append(k, appendMap[k])
      })
    }

    $.ajax({
        url: "/api/webhook",
        dataType: "json",
        headers: {
          "Authorization": "Basic " + window.userToken
        },
        method: "POST",
        enctype: "multipart/form-data",
        processData: false, // tell jQuery not to process the data
        contentType: false,
        data: formData
      })
      .done(function(j) {
        phxApp_.hide()
        if (j.status == "ok") {
          phxApp_.notify("Added!", {
            type: "success"
          });
          try {
            if (j.res != null) {

              successCallback(j.res)
            }

          } catch (e) {

          }
        } else {
          phxApp_.notify("Not added!", {
            type: "danger"
          });
        }

      }).fail(() => {
        phxApp_.notify("Not added!", {
          type: "danger"
        });

      })

  },
  html(page) {
    $(".modal-body").each((i, v) => {
      $(v).html('')
    })

    var prefix = "v2",
      res = ""
    $.ajax({
      async: false,
      method: "get",
      url: "/html/" + prefix + "/" + page
    }).done((j) => {
      res = j
    })
    return res;
  },
  api(scope, params, failed_callback, successCallback) {
    var res = ""
    $.ajax({
      async: false,
      method: "get",
      headers: {
        "Authorization": "Basic " + window.userToken
      },
      url: "/api/webhook?scope=" + scope,
      data: params
    }).done((j) => {
      if (successCallback != null) {

        successCallback(j)
      }
      res = j
    }).fail(function(e) {

      phxApp_.notify("Ops, somethings' not right!", {
        type: "danger"
      });
      this.show()
      setTimeout(() => {

        if (failed_callback != null) {
          failed_callback()
        }
        this.hide()
      }, 500)

    });
    return res;
  },
  post(scope, params, failed_callback, successCallback) {

    var res = ""
    $.ajax({
      async: false,
      method: "post",
      headers: {
        "Authorization": "Basic " + window.userToken
      },
      url: "/api/webhook?scope=" + scope,
      data: params
    }).done((j) => {
      if (successCallback != null) {

        successCallback(j)
      }
      res = j
    }).fail(function(e) {

      phxApp_.notify("Ops, somethings' not right!", {
        type: "danger"
      });

      setTimeout(() => {

        if (failed_callback != null) {
          failed_callback()
        }
        this.hide()
      }, 500)

    });
    return res;
  },
  evaluateLang() {

  },
  toTop() {

  },
  async navigateCallback() {
    memberApp_.restoreUser();
    commerceApp_.render();
    this.evaluateLang();
    this.toTop();
    this.hide();
  },
  show() {
    console.log("drop shadow..")
    $(".wrapper-ring").show()
    setTimeout(() => {
      $(".wrapper-ring").hide()
    }, 1000)
  },
  hide() {
        console.log("hide shadow..")
    try {
      $(".wrapper-ring").hide()
    } catch (e) {}
  }

}