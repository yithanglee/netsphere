// import jQuery from "./jquery.min";
// window.$ = window.jQuery = jQuery;
// import { jstree } from './jstree.min';
// import { slick } from './slick';
// import { notify } from './bootstrap.notify';
// import { DataTable } from './datatables';
import { Bootstrap } from './bootstrap.bundle.min';
import { commerceApp_ } from './commerce_app.js';
import { phxApp_ } from './phx_app.js';
import { memberApp_ } from './member_app.js';
import { Socket } from "./phoenix.js"
import { phoenixModel } from './phoenixModel.js';

$("html").attr("data-bs-theme", "light")
const useSw = false,
  isDev = window.location.hostname == "localhost";
if ('serviceWorker' in navigator && useSw) {
  navigator.serviceWorker.register('/sw.js')
    .then(registration => {
      console.log('Service Worker registered with scope:', registration.scope);
    })
    .catch(error => {
      console.error('Service Worker registration failed:', error);
    });
}

window.phoenixModel = phoenixModel;
window.phoenixModels = []
window.phxApp = phxApp_
if (isDev) {

  window.commerceApp = commerceApp_
  window.memberApp = memberApp_

}

window.addEventListener(
  "popstate",
  function(event) {
    try {

      // supposing rerun the navigate?
      if (history.valueOf().state != null) {
        // var adder = new Function(history.valueOf().state.fn);

        // console.log(history.valueOf().state.fn)
        window.back = true;
        window.parsePage = true;

        phxApp.navigateTo(history.valueOf().state.route)

        // adder();
      } else {
        phxApp.notify("cant back")
        phxApp.navigateTo("/home")
      }
    } catch (e) {
      // alert("!")

      console.log("!")
      // window.init();
    }
  },
  true
);

const route_list = [
  { html: "new_topup.html", title: "Register Point Topup ", route: "/topup_register_point" },
  { html: "upgrade.html", title: "Upgrade ", route: "/upgrade" },
  { html: "redeem.html", title: "Redeem ", route: "/redeem" },

  { html: "reward_details.html", title: "Reward Details ", route: "/reward_details/:name" },
  { html: "sales_detail.html", title: "Sales Details", route: "/sales/:id" },
  { html: "sales.html", title: "Sales History", route: "/sales" },
  { html: "wallet_transaction.html", title: "Transactions ", route: "/wallets/:id" },
  { html: "product.html", title: "Product", route: "/products/:id/:name" },
  { html: "register.html", title: "Register", route: "/register" },
  { html: "logout.html", title: "Logout", route: "/logout" },
  { html: "login.html", title: "Login", route: "/login" },
  { html: "profile.html", title: "Profile", route: "/profile" },
  { html: "placement.html", title: "Placement", route: "/placement" },
  { html: "placement_full.html", title: "Placement(Full)", route: "/placement_full" },
  { html: "referal.html", title: "Referal", route: "/referal" },
  { html: "gs_summary.html", title: "Group Sales", route: "/group_sales" },
]

route_list.forEach((v, i) => {
  phxApp_.route_names.push(v)
})


phxApp_.navigateTo();

const socket = new Socket("/socket", { params: { token: window.userToken } });

window.socket = socket;
socket.connect();

var buildFreshUrl = function(link) {
  var date = Math.round(Date.now() / 1000).toString();
  var url = link.href.replace(/(\&|\\?)vsn=\d*/, '');
  var newLink = document.createElement('link');
  var onComplete = function() {
    if (link.parentNode !== null) {
      link.parentNode.removeChild(link);
    }
  };

  newLink.onerror = onComplete;
  newLink.onload = onComplete;
  link.setAttribute('data-pending-removal', '');
  newLink.setAttribute('rel', 'stylesheet');
  newLink.setAttribute('type', 'text/css');
  newLink.setAttribute('href', url + (url.indexOf('?') >= 0 ? '&' : '?') + 'vsn=' + date);
  link.parentNode.insertBefore(newLink, link.nextSibling);

  return newLink;
};

var repaint = function() {
  var browser = navigator.userAgent.toLowerCase();
  if (browser.indexOf('chrome') > -1) {
    setTimeout(function() { document.body.offsetHeight; }, 25);
  }
};

var cssStrategy = function() {
  var reloadableLinkElements = window.parent.document.querySelectorAll(
    'link[rel=stylesheet]:not([data-no-reload]):not([data-pending-removal])'
  );

  [].slice
    .call(reloadableLinkElements)
    .filter(function(link) { return link.href })
    .forEach(function(link) { buildFreshUrl(link) });

  repaint();
};

var pageStrategy = function(chan) {
  chan.off('assets_change');
  window.top.location.reload();
};


var reloadStrategies = {
  css: cssStrategy,
  page: pageStrategy
};
if (isDev) {

  const rsocket = new Socket("/phoenix/live_reload/socket", { params: { token: window.userToken } });
  rsocket.connect();
  var chan = rsocket.channel('phoenix:live_reload', {})
  chan.on('assets_change', function(msg) {
    var reloadStrategy = reloadStrategies[msg.asset_type] || reloadStrategies.page;
    setTimeout(function() { reloadStrategy(chan); }, 1000);
  });
  chan.join();
}



$(document).on("click", "a.navi", function(event) {
  phxApp.show()
  event.preventDefault();
  setTimeout(() => {
    if ($(this).attr("href").includes("#")) {

    } else {

      phxApp_.navigateTo($(this).attr("href"))
    }
  }, 200)

});