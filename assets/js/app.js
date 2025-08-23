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
import { MENUS } from './menu.js';


$("html").attr("data-bs-theme", localStorage.getItem("data-bs-theme"))
window.showRP = true
window.includeShippingTax = true
window.toggleMcart = false
var useSw = false,
  isDev = window.location.hostname == "localhost";

if (isDev) {
  // phxApp_.post("admin_menus", { scope: "admin_menus", list: MENUS })
  useSw = false
}

if ('serviceWorker' in navigator && useSw) {
  navigator.serviceWorker.register('/sw.js')
    .then(registration => {
      console.log('Service Worker registered with scope:', registration.scope);
    })
    .catch(error => {
      console.error('Service Worker registration failed:', error);
    });
}


var langPrefix = "v2";
window.translationRes = "";


function evalCountry(countryName) {
  var prefix = "v2"

  if (countryName == "Thailand") {
    prefix = "th"
  }
  if (countryName == "Vietnam") {
    prefix = "vn"
  }
  if (countryName == "China") {
    prefix = "cn"
  }

  return prefix;
}


try {
  if (localStorage.region != null) {
    langPrefix = evalCountry(localStorage.region)
  }
  translationRes = phxApp_.api("translation", { lang: langPrefix });
} catch (error) {
  console.error("Error fetching translation:", error);
}
$.fn.extend({
  customHtml: async function(newHtml) {
    var translation_map = Object.keys(translationRes);
    var v2 = translation_map.reduce((acc, key) => {
      var regex = new RegExp(key, "g");
      return acc.replace(regex, translationRes[key]);
    }, newHtml);
    return this.html(v2);
  },
  customAppend: async function(newHtml) {

    var translation_map = Object.keys(translationRes);
    var v2 = translation_map.reduce((acc, key) => {

      var regex = new RegExp(key, "g");
      return acc.replace(regex, translationRes[key]);
    }, newHtml);


    return this.append(v2);
  }
});

window.phoenixModel = phoenixModel;
window.phoenixModels = []
window.phxApp = phxApp_
phxApp_.api("countries", {}, null, (e) => {
  window.countries = e
  phxApp_.countries_ = e
})
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
  { html: "merchant_withdrawal.html", title: "Merchant Withdrawal ", route: "/merchant_withdrawals" },

  { html: "merchant_application.html", title: "Merchant Application ", route: "/merchant_application" },
  { html: "merchant_profile.html", title: "Merchant Profile ", route: "/merchant_profile" },
  { html: "merchant_checkout_register.html", title: "Merchant Checkout ", route: "/merchant_checkout_register" },
  
  { html: "merchant_checkout.html", title: "Merchant Checkout ", route: "/merchant_checkout" },
  { html: "merchant_checkout_bd.html", title: "Merchant Checkout Back Date", route: "/merchant_checkout_bd" },
  { html: "merchant_purchases.html", title: "Merchant Purchases", route: "/merchant_purchases" },
  { html: "merchant_sales.html", title: "Merchant Sales", route: "/merchant_sales" },
  { html: "merchant_mall.html", title: "Merchant Mall", route: "/merchant_mall" },
  { html: "merchant_products.html", title: "Merchant Products", route: "/merchant_products" },
  { html: "mproduct.html", title: "Merchant Product", route: "/merchant_products/:id/:name" },

  { html: "refund_policy.html", title: "Refund Policy ", route: "/refund_policy", public: true, skipNav: true },
  { html: "terms_condition.html", title: "Terms Condition ", route: "/terms_condition", public: true, skipNav: true },
  { html: "merchant_code_register.html", title: "Register ", route: "/merchant_code_register/:share_code", public: true, skipNav: true },
  { html: "code_register.html", title: "Register ", route: "/code_register/:share_code", public: true, skipNav: true },
  { html: "register_wallet.html", title: "Register Wallet ", route: "/register_wallet" },
  { html: "bonus_wallet.html", title: "Bonus Wallet ", route: "/bonus_wallet" },
  { html: "new_topup.html", title: "Register Point Topup ", route: "/topup_register_point" },
  { html: "upgrade.html", title: "Upgrade ", route: "/upgrade" },
  { html: "redeem.html", title: "Redeem ", route: "/redeem" },
  { html: "withdrawal.html", title: "Withdrawal ", route: "/withdrawals" },
  { html: "reward_details.html", title: "Reward Details ", route: "/reward_details/:name/:month/:year" },
  { html: "sales_detail.html", title: "Sales Details", route: "/sales/:id" },
  { html: "sales.html", title: "Sales History", route: "/sales" },
  { html: "pay_instalment.html", title: "Pay Instalment", route: "/pay_instalment" },

  { html: "instalment_payments.html", title: "Instalment Payments", route: "/instalment_payments" },
  { html: "wallet_transaction.html", title: "Transactions ", route: "/wallets/:id" },
  { html: "product.html", title: "Product", route: "/products/:id/:name" },
  { html: "topup_card_register.html", title: "Topup Card Register", route: "/topup_card_register" },
  { html: "register.html", title: "Register", route: "/register" },
  { html: "logout.html", title: "Logout", route: "/logout", public: true },
  { html: "thank_you.html", title: "Login", route: "/thank_you", public: true },
  { html: "login.html", title: "Login", route: "/login", public: true },
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