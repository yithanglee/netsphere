import { commerceApp_ } from './commerce_app.js';
export let phxApp_ = {
  route_names: [
    { html: "landing.html", title: "Home", route: "/home" },


  ],
  ping() {

    console.log("tell ping o")
  },
  show() {

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
    phxApp.show()
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
      var footer_modals = phxApp.html("footer_modals.html")
      var html = phxApp.html(match_2[0].html)
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
        var nav = phxApp.html("blog_nav.html")
        if (keys.includes("customNav")) {
          var nav = phxApp.html(match_2[0].customNav)
        }
        $("#content").html(nav)
        $("#content").append(initPage)
        this.navigateCallback()
      }
      return match_2[0]
    } else {
      var footer_modals = phxApp.html("footer_modals.html")
      var html = phxApp.html("landing.html")
      var initPage = `
      <div class="page-content pb-0">
        ` + html + `
      </div>        ` + footer_modals + ``
      $("#content").html(initPage)
      this.navigateCallback()

    }
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

      phxApp.notify("Ops, somethings' not right!", {
        type: "danger"
      });
      phxApp.show()
      setTimeout(() => {

        if (failed_callback != null) {
          failed_callback()
        }
        phxApp.hide()
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

      phxApp.notify("Ops, somethings' not right!", {
        type: "danger"
      });
      phxApp.show()
      setTimeout(() => {

        if (failed_callback != null) {
          failed_callback()
        }
        phxApp.hide()
      }, 500)

    });
    return res;
  },
  evaluateLang() {

  },
  toTop() {

  },
  async navigateCallback() {
    commerceApp_.render()
    this.evaluateLang()
    this.toTop();
  }

}