(() => {
  var __create = Object.create;
  var __defProp = Object.defineProperty;
  var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
  var __getOwnPropNames = Object.getOwnPropertyNames;
  var __getProtoOf = Object.getPrototypeOf;
  var __hasOwnProp = Object.prototype.hasOwnProperty;
  var __commonJS = (cb, mod) => function __require() {
    return mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
  };
  var __copyProps = (to, from, except, desc) => {
    if (from && typeof from === "object" || typeof from === "function") {
      for (let key of __getOwnPropNames(from))
        if (!__hasOwnProp.call(to, key) && key !== except)
          __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
    }
    return to;
  };
  var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
    // If the importer is in node compatibility mode or this is not an ESM
    // file that has been converted to a CommonJS file using a Babel-
    // compatible transform (i.e. "__esModule" has not been set), then set
    // "default" to the CommonJS "module.exports" for node compatibility.
    isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
    mod
  ));

  // assets/js/bootstrap.bundle.min.js
  var require_bootstrap_bundle_min = __commonJS({
    "assets/js/bootstrap.bundle.min.js"(exports, module) {
      !function(t, e) {
        "object" == typeof exports && "undefined" != typeof module ? module.exports = e() : "function" == typeof define && define.amd ? define(e) : (t = "undefined" != typeof globalThis ? globalThis : t || self).bootstrap = e();
      }(exports, function() {
        "use strict";
        const t = /* @__PURE__ */ new Map(), e = { set(e2, i2, n2) {
          t.has(e2) || t.set(e2, /* @__PURE__ */ new Map());
          const s2 = t.get(e2);
          s2.has(i2) || 0 === s2.size ? s2.set(i2, n2) : console.error(`Bootstrap doesn't allow more than one instance per element. Bound instance: ${Array.from(s2.keys())[0]}.`);
        }, get: (e2, i2) => t.has(e2) && t.get(e2).get(i2) || null, remove(e2, i2) {
          if (!t.has(e2)) return;
          const n2 = t.get(e2);
          n2.delete(i2), 0 === n2.size && t.delete(e2);
        } }, i = "transitionend", n = (t2) => (t2 && window.CSS && window.CSS.escape && (t2 = t2.replace(/#([^\s"#']+)/g, (t3, e2) => `#${CSS.escape(e2)}`)), t2), s = (t2) => {
          t2.dispatchEvent(new Event(i));
        }, o = (t2) => !(!t2 || "object" != typeof t2) && (void 0 !== t2.jquery && (t2 = t2[0]), void 0 !== t2.nodeType), r = (t2) => o(t2) ? t2.jquery ? t2[0] : t2 : "string" == typeof t2 && t2.length > 0 ? document.querySelector(n(t2)) : null, a = (t2) => {
          if (!o(t2) || 0 === t2.getClientRects().length) return false;
          const e2 = "visible" === getComputedStyle(t2).getPropertyValue("visibility"), i2 = t2.closest("details:not([open])");
          if (!i2) return e2;
          if (i2 !== t2) {
            const e3 = t2.closest("summary");
            if (e3 && e3.parentNode !== i2) return false;
            if (null === e3) return false;
          }
          return e2;
        }, l = (t2) => !t2 || t2.nodeType !== Node.ELEMENT_NODE || !!t2.classList.contains("disabled") || (void 0 !== t2.disabled ? t2.disabled : t2.hasAttribute("disabled") && "false" !== t2.getAttribute("disabled")), c2 = (t2) => {
          if (!document.documentElement.attachShadow) return null;
          if ("function" == typeof t2.getRootNode) {
            const e2 = t2.getRootNode();
            return e2 instanceof ShadowRoot ? e2 : null;
          }
          return t2 instanceof ShadowRoot ? t2 : t2.parentNode ? c2(t2.parentNode) : null;
        }, h = () => {
        }, d = (t2) => {
          t2.offsetHeight;
        }, u = () => window.jQuery && !document.body.hasAttribute("data-bs-no-jquery") ? window.jQuery : null, f = [], p2 = () => "rtl" === document.documentElement.dir, m = (t2) => {
          var e2;
          e2 = () => {
            const e3 = u();
            if (e3) {
              const i2 = t2.NAME, n2 = e3.fn[i2];
              e3.fn[i2] = t2.jQueryInterface, e3.fn[i2].Constructor = t2, e3.fn[i2].noConflict = () => (e3.fn[i2] = n2, t2.jQueryInterface);
            }
          }, "loading" === document.readyState ? (f.length || document.addEventListener("DOMContentLoaded", () => {
            for (const t3 of f) t3();
          }), f.push(e2)) : e2();
        }, g = (t2, e2 = [], i2 = t2) => "function" == typeof t2 ? t2(...e2) : i2, _ = (t2, e2, n2 = true) => {
          if (!n2) return void g(t2);
          const o2 = ((t3) => {
            if (!t3) return 0;
            let { transitionDuration: e3, transitionDelay: i2 } = window.getComputedStyle(t3);
            const n3 = Number.parseFloat(e3), s2 = Number.parseFloat(i2);
            return n3 || s2 ? (e3 = e3.split(",")[0], i2 = i2.split(",")[0], 1e3 * (Number.parseFloat(e3) + Number.parseFloat(i2))) : 0;
          })(e2) + 5;
          let r2 = false;
          const a2 = ({ target: n3 }) => {
            n3 === e2 && (r2 = true, e2.removeEventListener(i, a2), g(t2));
          };
          e2.addEventListener(i, a2), setTimeout(() => {
            r2 || s(e2);
          }, o2);
        }, b = (t2, e2, i2, n2) => {
          const s2 = t2.length;
          let o2 = t2.indexOf(e2);
          return -1 === o2 ? !i2 && n2 ? t2[s2 - 1] : t2[0] : (o2 += i2 ? 1 : -1, n2 && (o2 = (o2 + s2) % s2), t2[Math.max(0, Math.min(o2, s2 - 1))]);
        }, v = /[^.]*(?=\..*)\.|.*/, y = /\..*/, w = /::\d+$/, A = {};
        let E = 1;
        const T = { mouseenter: "mouseover", mouseleave: "mouseout" }, C = /* @__PURE__ */ new Set(["click", "dblclick", "mouseup", "mousedown", "contextmenu", "mousewheel", "DOMMouseScroll", "mouseover", "mouseout", "mousemove", "selectstart", "selectend", "keydown", "keypress", "keyup", "orientationchange", "touchstart", "touchmove", "touchend", "touchcancel", "pointerdown", "pointermove", "pointerup", "pointerleave", "pointercancel", "gesturestart", "gesturechange", "gestureend", "focus", "blur", "change", "reset", "select", "submit", "focusin", "focusout", "load", "unload", "beforeunload", "resize", "move", "DOMContentLoaded", "readystatechange", "error", "abort", "scroll"]);
        function O(t2, e2) {
          return e2 && `${e2}::${E++}` || t2.uidEvent || E++;
        }
        function x(t2) {
          const e2 = O(t2);
          return t2.uidEvent = e2, A[e2] = A[e2] || {}, A[e2];
        }
        function k(t2, e2, i2 = null) {
          return Object.values(t2).find((t3) => t3.callable === e2 && t3.delegationSelector === i2);
        }
        function L(t2, e2, i2) {
          const n2 = "string" == typeof e2, s2 = n2 ? i2 : e2 || i2;
          let o2 = I(t2);
          return C.has(o2) || (o2 = t2), [n2, s2, o2];
        }
        function S(t2, e2, i2, n2, s2) {
          if ("string" != typeof e2 || !t2) return;
          let [o2, r2, a2] = L(e2, i2, n2);
          if (e2 in T) {
            const t3 = (t4) => function(e3) {
              if (!e3.relatedTarget || e3.relatedTarget !== e3.delegateTarget && !e3.delegateTarget.contains(e3.relatedTarget)) return t4.call(this, e3);
            };
            r2 = t3(r2);
          }
          const l2 = x(t2), c3 = l2[a2] || (l2[a2] = {}), h2 = k(c3, r2, o2 ? i2 : null);
          if (h2) return void (h2.oneOff = h2.oneOff && s2);
          const d2 = O(r2, e2.replace(v, "")), u2 = o2 ? /* @__PURE__ */ function(t3, e3, i3) {
            return function n3(s3) {
              const o3 = t3.querySelectorAll(e3);
              for (let { target: r3 } = s3; r3 && r3 !== this; r3 = r3.parentNode) for (const a3 of o3) if (a3 === r3) return P(s3, { delegateTarget: r3 }), n3.oneOff && N.off(t3, s3.type, e3, i3), i3.apply(r3, [s3]);
            };
          }(t2, i2, r2) : /* @__PURE__ */ function(t3, e3) {
            return function i3(n3) {
              return P(n3, { delegateTarget: t3 }), i3.oneOff && N.off(t3, n3.type, e3), e3.apply(t3, [n3]);
            };
          }(t2, r2);
          u2.delegationSelector = o2 ? i2 : null, u2.callable = r2, u2.oneOff = s2, u2.uidEvent = d2, c3[d2] = u2, t2.addEventListener(a2, u2, o2);
        }
        function D(t2, e2, i2, n2, s2) {
          const o2 = k(e2[i2], n2, s2);
          o2 && (t2.removeEventListener(i2, o2, Boolean(s2)), delete e2[i2][o2.uidEvent]);
        }
        function $2(t2, e2, i2, n2) {
          const s2 = e2[i2] || {};
          for (const [o2, r2] of Object.entries(s2)) o2.includes(n2) && D(t2, e2, i2, r2.callable, r2.delegationSelector);
        }
        function I(t2) {
          return t2 = t2.replace(y, ""), T[t2] || t2;
        }
        const N = { on(t2, e2, i2, n2) {
          S(t2, e2, i2, n2, false);
        }, one(t2, e2, i2, n2) {
          S(t2, e2, i2, n2, true);
        }, off(t2, e2, i2, n2) {
          if ("string" != typeof e2 || !t2) return;
          const [s2, o2, r2] = L(e2, i2, n2), a2 = r2 !== e2, l2 = x(t2), c3 = l2[r2] || {}, h2 = e2.startsWith(".");
          if (void 0 === o2) {
            if (h2) for (const i3 of Object.keys(l2)) $2(t2, l2, i3, e2.slice(1));
            for (const [i3, n3] of Object.entries(c3)) {
              const s3 = i3.replace(w, "");
              a2 && !e2.includes(s3) || D(t2, l2, r2, n3.callable, n3.delegationSelector);
            }
          } else {
            if (!Object.keys(c3).length) return;
            D(t2, l2, r2, o2, s2 ? i2 : null);
          }
        }, trigger(t2, e2, i2) {
          if ("string" != typeof e2 || !t2) return null;
          const n2 = u();
          let s2 = null, o2 = true, r2 = true, a2 = false;
          e2 !== I(e2) && n2 && (s2 = n2.Event(e2, i2), n2(t2).trigger(s2), o2 = !s2.isPropagationStopped(), r2 = !s2.isImmediatePropagationStopped(), a2 = s2.isDefaultPrevented());
          const l2 = P(new Event(e2, { bubbles: o2, cancelable: true }), i2);
          return a2 && l2.preventDefault(), r2 && t2.dispatchEvent(l2), l2.defaultPrevented && s2 && s2.preventDefault(), l2;
        } };
        function P(t2, e2 = {}) {
          for (const [i2, n2] of Object.entries(e2)) try {
            t2[i2] = n2;
          } catch (e3) {
            Object.defineProperty(t2, i2, { configurable: true, get: () => n2 });
          }
          return t2;
        }
        function M(t2) {
          if ("true" === t2) return true;
          if ("false" === t2) return false;
          if (t2 === Number(t2).toString()) return Number(t2);
          if ("" === t2 || "null" === t2) return null;
          if ("string" != typeof t2) return t2;
          try {
            return JSON.parse(decodeURIComponent(t2));
          } catch (e2) {
            return t2;
          }
        }
        function j(t2) {
          return t2.replace(/[A-Z]/g, (t3) => `-${t3.toLowerCase()}`);
        }
        const F = { setDataAttribute(t2, e2, i2) {
          t2.setAttribute(`data-bs-${j(e2)}`, i2);
        }, removeDataAttribute(t2, e2) {
          t2.removeAttribute(`data-bs-${j(e2)}`);
        }, getDataAttributes(t2) {
          if (!t2) return {};
          const e2 = {}, i2 = Object.keys(t2.dataset).filter((t3) => t3.startsWith("bs") && !t3.startsWith("bsConfig"));
          for (const n2 of i2) {
            let i3 = n2.replace(/^bs/, "");
            i3 = i3.charAt(0).toLowerCase() + i3.slice(1, i3.length), e2[i3] = M(t2.dataset[n2]);
          }
          return e2;
        }, getDataAttribute: (t2, e2) => M(t2.getAttribute(`data-bs-${j(e2)}`)) };
        class H {
          static get Default() {
            return {};
          }
          static get DefaultType() {
            return {};
          }
          static get NAME() {
            throw new Error('You have to implement the static method "NAME", for each component!');
          }
          _getConfig(t2) {
            return t2 = this._mergeConfigObj(t2), t2 = this._configAfterMerge(t2), this._typeCheckConfig(t2), t2;
          }
          _configAfterMerge(t2) {
            return t2;
          }
          _mergeConfigObj(t2, e2) {
            const i2 = o(e2) ? F.getDataAttribute(e2, "config") : {};
            return { ...this.constructor.Default, ..."object" == typeof i2 ? i2 : {}, ...o(e2) ? F.getDataAttributes(e2) : {}, ..."object" == typeof t2 ? t2 : {} };
          }
          _typeCheckConfig(t2, e2 = this.constructor.DefaultType) {
            for (const [n2, s2] of Object.entries(e2)) {
              const e3 = t2[n2], r2 = o(e3) ? "element" : null == (i2 = e3) ? `${i2}` : Object.prototype.toString.call(i2).match(/\s([a-z]+)/i)[1].toLowerCase();
              if (!new RegExp(s2).test(r2)) throw new TypeError(`${this.constructor.NAME.toUpperCase()}: Option "${n2}" provided type "${r2}" but expected type "${s2}".`);
            }
            var i2;
          }
        }
        class W extends H {
          constructor(t2, i2) {
            super(), (t2 = r(t2)) && (this._element = t2, this._config = this._getConfig(i2), e.set(this._element, this.constructor.DATA_KEY, this));
          }
          dispose() {
            e.remove(this._element, this.constructor.DATA_KEY), N.off(this._element, this.constructor.EVENT_KEY);
            for (const t2 of Object.getOwnPropertyNames(this)) this[t2] = null;
          }
          _queueCallback(t2, e2, i2 = true) {
            _(t2, e2, i2);
          }
          _getConfig(t2) {
            return t2 = this._mergeConfigObj(t2, this._element), t2 = this._configAfterMerge(t2), this._typeCheckConfig(t2), t2;
          }
          static getInstance(t2) {
            return e.get(r(t2), this.DATA_KEY);
          }
          static getOrCreateInstance(t2, e2 = {}) {
            return this.getInstance(t2) || new this(t2, "object" == typeof e2 ? e2 : null);
          }
          static get VERSION() {
            return "5.3.2";
          }
          static get DATA_KEY() {
            return `bs.${this.NAME}`;
          }
          static get EVENT_KEY() {
            return `.${this.DATA_KEY}`;
          }
          static eventName(t2) {
            return `${t2}${this.EVENT_KEY}`;
          }
        }
        const B = (t2) => {
          let e2 = t2.getAttribute("data-bs-target");
          if (!e2 || "#" === e2) {
            let i2 = t2.getAttribute("href");
            if (!i2 || !i2.includes("#") && !i2.startsWith(".")) return null;
            i2.includes("#") && !i2.startsWith("#") && (i2 = `#${i2.split("#")[1]}`), e2 = i2 && "#" !== i2 ? n(i2.trim()) : null;
          }
          return e2;
        }, z = { find: (t2, e2 = document.documentElement) => [].concat(...Element.prototype.querySelectorAll.call(e2, t2)), findOne: (t2, e2 = document.documentElement) => Element.prototype.querySelector.call(e2, t2), children: (t2, e2) => [].concat(...t2.children).filter((t3) => t3.matches(e2)), parents(t2, e2) {
          const i2 = [];
          let n2 = t2.parentNode.closest(e2);
          for (; n2; ) i2.push(n2), n2 = n2.parentNode.closest(e2);
          return i2;
        }, prev(t2, e2) {
          let i2 = t2.previousElementSibling;
          for (; i2; ) {
            if (i2.matches(e2)) return [i2];
            i2 = i2.previousElementSibling;
          }
          return [];
        }, next(t2, e2) {
          let i2 = t2.nextElementSibling;
          for (; i2; ) {
            if (i2.matches(e2)) return [i2];
            i2 = i2.nextElementSibling;
          }
          return [];
        }, focusableChildren(t2) {
          const e2 = ["a", "button", "input", "textarea", "select", "details", "[tabindex]", '[contenteditable="true"]'].map((t3) => `${t3}:not([tabindex^="-"])`).join(",");
          return this.find(e2, t2).filter((t3) => !l(t3) && a(t3));
        }, getSelectorFromElement(t2) {
          const e2 = B(t2);
          return e2 && z.findOne(e2) ? e2 : null;
        }, getElementFromSelector(t2) {
          const e2 = B(t2);
          return e2 ? z.findOne(e2) : null;
        }, getMultipleElementsFromSelector(t2) {
          const e2 = B(t2);
          return e2 ? z.find(e2) : [];
        } }, R = (t2, e2 = "hide") => {
          const i2 = `click.dismiss${t2.EVENT_KEY}`, n2 = t2.NAME;
          N.on(document, i2, `[data-bs-dismiss="${n2}"]`, function(i3) {
            if (["A", "AREA"].includes(this.tagName) && i3.preventDefault(), l(this)) return;
            const s2 = z.getElementFromSelector(this) || this.closest(`.${n2}`);
            t2.getOrCreateInstance(s2)[e2]();
          });
        }, q = ".bs.alert", V = `close${q}`, K = `closed${q}`;
        class Q extends W {
          static get NAME() {
            return "alert";
          }
          close() {
            if (N.trigger(this._element, V).defaultPrevented) return;
            this._element.classList.remove("show");
            const t2 = this._element.classList.contains("fade");
            this._queueCallback(() => this._destroyElement(), this._element, t2);
          }
          _destroyElement() {
            this._element.remove(), N.trigger(this._element, K), this.dispose();
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = Q.getOrCreateInstance(this);
              if ("string" == typeof t2) {
                if (void 0 === e2[t2] || t2.startsWith("_") || "constructor" === t2) throw new TypeError(`No method named "${t2}"`);
                e2[t2](this);
              }
            });
          }
        }
        R(Q, "close"), m(Q);
        const X = '[data-bs-toggle="button"]';
        class Y extends W {
          static get NAME() {
            return "button";
          }
          toggle() {
            this._element.setAttribute("aria-pressed", this._element.classList.toggle("active"));
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = Y.getOrCreateInstance(this);
              "toggle" === t2 && e2[t2]();
            });
          }
        }
        N.on(document, "click.bs.button.data-api", X, (t2) => {
          t2.preventDefault();
          const e2 = t2.target.closest(X);
          Y.getOrCreateInstance(e2).toggle();
        }), m(Y);
        const U = ".bs.swipe", G = `touchstart${U}`, J = `touchmove${U}`, Z = `touchend${U}`, tt = `pointerdown${U}`, et = `pointerup${U}`, it = { endCallback: null, leftCallback: null, rightCallback: null }, nt = { endCallback: "(function|null)", leftCallback: "(function|null)", rightCallback: "(function|null)" };
        class st extends H {
          constructor(t2, e2) {
            super(), this._element = t2, t2 && st.isSupported() && (this._config = this._getConfig(e2), this._deltaX = 0, this._supportPointerEvents = Boolean(window.PointerEvent), this._initEvents());
          }
          static get Default() {
            return it;
          }
          static get DefaultType() {
            return nt;
          }
          static get NAME() {
            return "swipe";
          }
          dispose() {
            N.off(this._element, U);
          }
          _start(t2) {
            this._supportPointerEvents ? this._eventIsPointerPenTouch(t2) && (this._deltaX = t2.clientX) : this._deltaX = t2.touches[0].clientX;
          }
          _end(t2) {
            this._eventIsPointerPenTouch(t2) && (this._deltaX = t2.clientX - this._deltaX), this._handleSwipe(), g(this._config.endCallback);
          }
          _move(t2) {
            this._deltaX = t2.touches && t2.touches.length > 1 ? 0 : t2.touches[0].clientX - this._deltaX;
          }
          _handleSwipe() {
            const t2 = Math.abs(this._deltaX);
            if (t2 <= 40) return;
            const e2 = t2 / this._deltaX;
            this._deltaX = 0, e2 && g(e2 > 0 ? this._config.rightCallback : this._config.leftCallback);
          }
          _initEvents() {
            this._supportPointerEvents ? (N.on(this._element, tt, (t2) => this._start(t2)), N.on(this._element, et, (t2) => this._end(t2)), this._element.classList.add("pointer-event")) : (N.on(this._element, G, (t2) => this._start(t2)), N.on(this._element, J, (t2) => this._move(t2)), N.on(this._element, Z, (t2) => this._end(t2)));
          }
          _eventIsPointerPenTouch(t2) {
            return this._supportPointerEvents && ("pen" === t2.pointerType || "touch" === t2.pointerType);
          }
          static isSupported() {
            return "ontouchstart" in document.documentElement || navigator.maxTouchPoints > 0;
          }
        }
        const ot = ".bs.carousel", rt = ".data-api", at = "next", lt = "prev", ct = "left", ht = "right", dt = `slide${ot}`, ut = `slid${ot}`, ft = `keydown${ot}`, pt = `mouseenter${ot}`, mt = `mouseleave${ot}`, gt = `dragstart${ot}`, _t = `load${ot}${rt}`, bt = `click${ot}${rt}`, vt = "carousel", yt = "active", wt = ".active", At = ".carousel-item", Et = wt + At, Tt = { ArrowLeft: ht, ArrowRight: ct }, Ct = { interval: 5e3, keyboard: true, pause: "hover", ride: false, touch: true, wrap: true }, Ot = { interval: "(number|boolean)", keyboard: "boolean", pause: "(string|boolean)", ride: "(boolean|string)", touch: "boolean", wrap: "boolean" };
        class xt extends W {
          constructor(t2, e2) {
            super(t2, e2), this._interval = null, this._activeElement = null, this._isSliding = false, this.touchTimeout = null, this._swipeHelper = null, this._indicatorsElement = z.findOne(".carousel-indicators", this._element), this._addEventListeners(), this._config.ride === vt && this.cycle();
          }
          static get Default() {
            return Ct;
          }
          static get DefaultType() {
            return Ot;
          }
          static get NAME() {
            return "carousel";
          }
          next() {
            this._slide(at);
          }
          nextWhenVisible() {
            !document.hidden && a(this._element) && this.next();
          }
          prev() {
            this._slide(lt);
          }
          pause() {
            this._isSliding && s(this._element), this._clearInterval();
          }
          cycle() {
            this._clearInterval(), this._updateInterval(), this._interval = setInterval(() => this.nextWhenVisible(), this._config.interval);
          }
          _maybeEnableCycle() {
            this._config.ride && (this._isSliding ? N.one(this._element, ut, () => this.cycle()) : this.cycle());
          }
          to(t2) {
            const e2 = this._getItems();
            if (t2 > e2.length - 1 || t2 < 0) return;
            if (this._isSliding) return void N.one(this._element, ut, () => this.to(t2));
            const i2 = this._getItemIndex(this._getActive());
            if (i2 === t2) return;
            const n2 = t2 > i2 ? at : lt;
            this._slide(n2, e2[t2]);
          }
          dispose() {
            this._swipeHelper && this._swipeHelper.dispose(), super.dispose();
          }
          _configAfterMerge(t2) {
            return t2.defaultInterval = t2.interval, t2;
          }
          _addEventListeners() {
            this._config.keyboard && N.on(this._element, ft, (t2) => this._keydown(t2)), "hover" === this._config.pause && (N.on(this._element, pt, () => this.pause()), N.on(this._element, mt, () => this._maybeEnableCycle())), this._config.touch && st.isSupported() && this._addTouchEventListeners();
          }
          _addTouchEventListeners() {
            for (const t3 of z.find(".carousel-item img", this._element)) N.on(t3, gt, (t4) => t4.preventDefault());
            const t2 = { leftCallback: () => this._slide(this._directionToOrder(ct)), rightCallback: () => this._slide(this._directionToOrder(ht)), endCallback: () => {
              "hover" === this._config.pause && (this.pause(), this.touchTimeout && clearTimeout(this.touchTimeout), this.touchTimeout = setTimeout(() => this._maybeEnableCycle(), 500 + this._config.interval));
            } };
            this._swipeHelper = new st(this._element, t2);
          }
          _keydown(t2) {
            if (/input|textarea/i.test(t2.target.tagName)) return;
            const e2 = Tt[t2.key];
            e2 && (t2.preventDefault(), this._slide(this._directionToOrder(e2)));
          }
          _getItemIndex(t2) {
            return this._getItems().indexOf(t2);
          }
          _setActiveIndicatorElement(t2) {
            if (!this._indicatorsElement) return;
            const e2 = z.findOne(wt, this._indicatorsElement);
            e2.classList.remove(yt), e2.removeAttribute("aria-current");
            const i2 = z.findOne(`[data-bs-slide-to="${t2}"]`, this._indicatorsElement);
            i2 && (i2.classList.add(yt), i2.setAttribute("aria-current", "true"));
          }
          _updateInterval() {
            const t2 = this._activeElement || this._getActive();
            if (!t2) return;
            const e2 = Number.parseInt(t2.getAttribute("data-bs-interval"), 10);
            this._config.interval = e2 || this._config.defaultInterval;
          }
          _slide(t2, e2 = null) {
            if (this._isSliding) return;
            const i2 = this._getActive(), n2 = t2 === at, s2 = e2 || b(this._getItems(), i2, n2, this._config.wrap);
            if (s2 === i2) return;
            const o2 = this._getItemIndex(s2), r2 = (e3) => N.trigger(this._element, e3, { relatedTarget: s2, direction: this._orderToDirection(t2), from: this._getItemIndex(i2), to: o2 });
            if (r2(dt).defaultPrevented) return;
            if (!i2 || !s2) return;
            const a2 = Boolean(this._interval);
            this.pause(), this._isSliding = true, this._setActiveIndicatorElement(o2), this._activeElement = s2;
            const l2 = n2 ? "carousel-item-start" : "carousel-item-end", c3 = n2 ? "carousel-item-next" : "carousel-item-prev";
            s2.classList.add(c3), d(s2), i2.classList.add(l2), s2.classList.add(l2), this._queueCallback(() => {
              s2.classList.remove(l2, c3), s2.classList.add(yt), i2.classList.remove(yt, c3, l2), this._isSliding = false, r2(ut);
            }, i2, this._isAnimated()), a2 && this.cycle();
          }
          _isAnimated() {
            return this._element.classList.contains("slide");
          }
          _getActive() {
            return z.findOne(Et, this._element);
          }
          _getItems() {
            return z.find(At, this._element);
          }
          _clearInterval() {
            this._interval && (clearInterval(this._interval), this._interval = null);
          }
          _directionToOrder(t2) {
            return p2() ? t2 === ct ? lt : at : t2 === ct ? at : lt;
          }
          _orderToDirection(t2) {
            return p2() ? t2 === lt ? ct : ht : t2 === lt ? ht : ct;
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = xt.getOrCreateInstance(this, t2);
              if ("number" != typeof t2) {
                if ("string" == typeof t2) {
                  if (void 0 === e2[t2] || t2.startsWith("_") || "constructor" === t2) throw new TypeError(`No method named "${t2}"`);
                  e2[t2]();
                }
              } else e2.to(t2);
            });
          }
        }
        N.on(document, bt, "[data-bs-slide], [data-bs-slide-to]", function(t2) {
          const e2 = z.getElementFromSelector(this);
          if (!e2 || !e2.classList.contains(vt)) return;
          t2.preventDefault();
          const i2 = xt.getOrCreateInstance(e2), n2 = this.getAttribute("data-bs-slide-to");
          return n2 ? (i2.to(n2), void i2._maybeEnableCycle()) : "next" === F.getDataAttribute(this, "slide") ? (i2.next(), void i2._maybeEnableCycle()) : (i2.prev(), void i2._maybeEnableCycle());
        }), N.on(window, _t, () => {
          const t2 = z.find('[data-bs-ride="carousel"]');
          for (const e2 of t2) xt.getOrCreateInstance(e2);
        }), m(xt);
        const kt = ".bs.collapse", Lt = `show${kt}`, St = `shown${kt}`, Dt = `hide${kt}`, $t = `hidden${kt}`, It = `click${kt}.data-api`, Nt = "show", Pt = "collapse", Mt = "collapsing", jt = `:scope .${Pt} .${Pt}`, Ft = '[data-bs-toggle="collapse"]', Ht = { parent: null, toggle: true }, Wt = { parent: "(null|element)", toggle: "boolean" };
        class Bt extends W {
          constructor(t2, e2) {
            super(t2, e2), this._isTransitioning = false, this._triggerArray = [];
            const i2 = z.find(Ft);
            for (const t3 of i2) {
              const e3 = z.getSelectorFromElement(t3), i3 = z.find(e3).filter((t4) => t4 === this._element);
              null !== e3 && i3.length && this._triggerArray.push(t3);
            }
            this._initializeChildren(), this._config.parent || this._addAriaAndCollapsedClass(this._triggerArray, this._isShown()), this._config.toggle && this.toggle();
          }
          static get Default() {
            return Ht;
          }
          static get DefaultType() {
            return Wt;
          }
          static get NAME() {
            return "collapse";
          }
          toggle() {
            this._isShown() ? this.hide() : this.show();
          }
          show() {
            if (this._isTransitioning || this._isShown()) return;
            let t2 = [];
            if (this._config.parent && (t2 = this._getFirstLevelChildren(".collapse.show, .collapse.collapsing").filter((t3) => t3 !== this._element).map((t3) => Bt.getOrCreateInstance(t3, { toggle: false }))), t2.length && t2[0]._isTransitioning) return;
            if (N.trigger(this._element, Lt).defaultPrevented) return;
            for (const e3 of t2) e3.hide();
            const e2 = this._getDimension();
            this._element.classList.remove(Pt), this._element.classList.add(Mt), this._element.style[e2] = 0, this._addAriaAndCollapsedClass(this._triggerArray, true), this._isTransitioning = true;
            const i2 = `scroll${e2[0].toUpperCase() + e2.slice(1)}`;
            this._queueCallback(() => {
              this._isTransitioning = false, this._element.classList.remove(Mt), this._element.classList.add(Pt, Nt), this._element.style[e2] = "", N.trigger(this._element, St);
            }, this._element, true), this._element.style[e2] = `${this._element[i2]}px`;
          }
          hide() {
            if (this._isTransitioning || !this._isShown()) return;
            if (N.trigger(this._element, Dt).defaultPrevented) return;
            const t2 = this._getDimension();
            this._element.style[t2] = `${this._element.getBoundingClientRect()[t2]}px`, d(this._element), this._element.classList.add(Mt), this._element.classList.remove(Pt, Nt);
            for (const t3 of this._triggerArray) {
              const e2 = z.getElementFromSelector(t3);
              e2 && !this._isShown(e2) && this._addAriaAndCollapsedClass([t3], false);
            }
            this._isTransitioning = true, this._element.style[t2] = "", this._queueCallback(() => {
              this._isTransitioning = false, this._element.classList.remove(Mt), this._element.classList.add(Pt), N.trigger(this._element, $t);
            }, this._element, true);
          }
          _isShown(t2 = this._element) {
            return t2.classList.contains(Nt);
          }
          _configAfterMerge(t2) {
            return t2.toggle = Boolean(t2.toggle), t2.parent = r(t2.parent), t2;
          }
          _getDimension() {
            return this._element.classList.contains("collapse-horizontal") ? "width" : "height";
          }
          _initializeChildren() {
            if (!this._config.parent) return;
            const t2 = this._getFirstLevelChildren(Ft);
            for (const e2 of t2) {
              const t3 = z.getElementFromSelector(e2);
              t3 && this._addAriaAndCollapsedClass([e2], this._isShown(t3));
            }
          }
          _getFirstLevelChildren(t2) {
            const e2 = z.find(jt, this._config.parent);
            return z.find(t2, this._config.parent).filter((t3) => !e2.includes(t3));
          }
          _addAriaAndCollapsedClass(t2, e2) {
            if (t2.length) for (const i2 of t2) i2.classList.toggle("collapsed", !e2), i2.setAttribute("aria-expanded", e2);
          }
          static jQueryInterface(t2) {
            const e2 = {};
            return "string" == typeof t2 && /show|hide/.test(t2) && (e2.toggle = false), this.each(function() {
              const i2 = Bt.getOrCreateInstance(this, e2);
              if ("string" == typeof t2) {
                if (void 0 === i2[t2]) throw new TypeError(`No method named "${t2}"`);
                i2[t2]();
              }
            });
          }
        }
        N.on(document, It, Ft, function(t2) {
          ("A" === t2.target.tagName || t2.delegateTarget && "A" === t2.delegateTarget.tagName) && t2.preventDefault();
          for (const t3 of z.getMultipleElementsFromSelector(this)) Bt.getOrCreateInstance(t3, { toggle: false }).toggle();
        }), m(Bt);
        var zt = "top", Rt = "bottom", qt = "right", Vt = "left", Kt = "auto", Qt = [zt, Rt, qt, Vt], Xt = "start", Yt = "end", Ut = "clippingParents", Gt = "viewport", Jt = "popper", Zt = "reference", te = Qt.reduce(function(t2, e2) {
          return t2.concat([e2 + "-" + Xt, e2 + "-" + Yt]);
        }, []), ee = [].concat(Qt, [Kt]).reduce(function(t2, e2) {
          return t2.concat([e2, e2 + "-" + Xt, e2 + "-" + Yt]);
        }, []), ie = "beforeRead", ne = "read", se = "afterRead", oe = "beforeMain", re = "main", ae = "afterMain", le = "beforeWrite", ce = "write", he = "afterWrite", de = [ie, ne, se, oe, re, ae, le, ce, he];
        function ue(t2) {
          return t2 ? (t2.nodeName || "").toLowerCase() : null;
        }
        function fe(t2) {
          if (null == t2) return window;
          if ("[object Window]" !== t2.toString()) {
            var e2 = t2.ownerDocument;
            return e2 && e2.defaultView || window;
          }
          return t2;
        }
        function pe(t2) {
          return t2 instanceof fe(t2).Element || t2 instanceof Element;
        }
        function me(t2) {
          return t2 instanceof fe(t2).HTMLElement || t2 instanceof HTMLElement;
        }
        function ge(t2) {
          return "undefined" != typeof ShadowRoot && (t2 instanceof fe(t2).ShadowRoot || t2 instanceof ShadowRoot);
        }
        const _e = { name: "applyStyles", enabled: true, phase: "write", fn: function(t2) {
          var e2 = t2.state;
          Object.keys(e2.elements).forEach(function(t3) {
            var i2 = e2.styles[t3] || {}, n2 = e2.attributes[t3] || {}, s2 = e2.elements[t3];
            me(s2) && ue(s2) && (Object.assign(s2.style, i2), Object.keys(n2).forEach(function(t4) {
              var e3 = n2[t4];
              false === e3 ? s2.removeAttribute(t4) : s2.setAttribute(t4, true === e3 ? "" : e3);
            }));
          });
        }, effect: function(t2) {
          var e2 = t2.state, i2 = { popper: { position: e2.options.strategy, left: "0", top: "0", margin: "0" }, arrow: { position: "absolute" }, reference: {} };
          return Object.assign(e2.elements.popper.style, i2.popper), e2.styles = i2, e2.elements.arrow && Object.assign(e2.elements.arrow.style, i2.arrow), function() {
            Object.keys(e2.elements).forEach(function(t3) {
              var n2 = e2.elements[t3], s2 = e2.attributes[t3] || {}, o2 = Object.keys(e2.styles.hasOwnProperty(t3) ? e2.styles[t3] : i2[t3]).reduce(function(t4, e3) {
                return t4[e3] = "", t4;
              }, {});
              me(n2) && ue(n2) && (Object.assign(n2.style, o2), Object.keys(s2).forEach(function(t4) {
                n2.removeAttribute(t4);
              }));
            });
          };
        }, requires: ["computeStyles"] };
        function be(t2) {
          return t2.split("-")[0];
        }
        var ve = Math.max, ye = Math.min, we = Math.round;
        function Ae() {
          var t2 = navigator.userAgentData;
          return null != t2 && t2.brands && Array.isArray(t2.brands) ? t2.brands.map(function(t3) {
            return t3.brand + "/" + t3.version;
          }).join(" ") : navigator.userAgent;
        }
        function Ee() {
          return !/^((?!chrome|android).)*safari/i.test(Ae());
        }
        function Te(t2, e2, i2) {
          void 0 === e2 && (e2 = false), void 0 === i2 && (i2 = false);
          var n2 = t2.getBoundingClientRect(), s2 = 1, o2 = 1;
          e2 && me(t2) && (s2 = t2.offsetWidth > 0 && we(n2.width) / t2.offsetWidth || 1, o2 = t2.offsetHeight > 0 && we(n2.height) / t2.offsetHeight || 1);
          var r2 = (pe(t2) ? fe(t2) : window).visualViewport, a2 = !Ee() && i2, l2 = (n2.left + (a2 && r2 ? r2.offsetLeft : 0)) / s2, c3 = (n2.top + (a2 && r2 ? r2.offsetTop : 0)) / o2, h2 = n2.width / s2, d2 = n2.height / o2;
          return { width: h2, height: d2, top: c3, right: l2 + h2, bottom: c3 + d2, left: l2, x: l2, y: c3 };
        }
        function Ce(t2) {
          var e2 = Te(t2), i2 = t2.offsetWidth, n2 = t2.offsetHeight;
          return Math.abs(e2.width - i2) <= 1 && (i2 = e2.width), Math.abs(e2.height - n2) <= 1 && (n2 = e2.height), { x: t2.offsetLeft, y: t2.offsetTop, width: i2, height: n2 };
        }
        function Oe(t2, e2) {
          var i2 = e2.getRootNode && e2.getRootNode();
          if (t2.contains(e2)) return true;
          if (i2 && ge(i2)) {
            var n2 = e2;
            do {
              if (n2 && t2.isSameNode(n2)) return true;
              n2 = n2.parentNode || n2.host;
            } while (n2);
          }
          return false;
        }
        function xe(t2) {
          return fe(t2).getComputedStyle(t2);
        }
        function ke(t2) {
          return ["table", "td", "th"].indexOf(ue(t2)) >= 0;
        }
        function Le(t2) {
          return ((pe(t2) ? t2.ownerDocument : t2.document) || window.document).documentElement;
        }
        function Se(t2) {
          return "html" === ue(t2) ? t2 : t2.assignedSlot || t2.parentNode || (ge(t2) ? t2.host : null) || Le(t2);
        }
        function De(t2) {
          return me(t2) && "fixed" !== xe(t2).position ? t2.offsetParent : null;
        }
        function $e(t2) {
          for (var e2 = fe(t2), i2 = De(t2); i2 && ke(i2) && "static" === xe(i2).position; ) i2 = De(i2);
          return i2 && ("html" === ue(i2) || "body" === ue(i2) && "static" === xe(i2).position) ? e2 : i2 || function(t3) {
            var e3 = /firefox/i.test(Ae());
            if (/Trident/i.test(Ae()) && me(t3) && "fixed" === xe(t3).position) return null;
            var i3 = Se(t3);
            for (ge(i3) && (i3 = i3.host); me(i3) && ["html", "body"].indexOf(ue(i3)) < 0; ) {
              var n2 = xe(i3);
              if ("none" !== n2.transform || "none" !== n2.perspective || "paint" === n2.contain || -1 !== ["transform", "perspective"].indexOf(n2.willChange) || e3 && "filter" === n2.willChange || e3 && n2.filter && "none" !== n2.filter) return i3;
              i3 = i3.parentNode;
            }
            return null;
          }(t2) || e2;
        }
        function Ie(t2) {
          return ["top", "bottom"].indexOf(t2) >= 0 ? "x" : "y";
        }
        function Ne(t2, e2, i2) {
          return ve(t2, ye(e2, i2));
        }
        function Pe(t2) {
          return Object.assign({}, { top: 0, right: 0, bottom: 0, left: 0 }, t2);
        }
        function Me(t2, e2) {
          return e2.reduce(function(e3, i2) {
            return e3[i2] = t2, e3;
          }, {});
        }
        const je = { name: "arrow", enabled: true, phase: "main", fn: function(t2) {
          var e2, i2 = t2.state, n2 = t2.name, s2 = t2.options, o2 = i2.elements.arrow, r2 = i2.modifiersData.popperOffsets, a2 = be(i2.placement), l2 = Ie(a2), c3 = [Vt, qt].indexOf(a2) >= 0 ? "height" : "width";
          if (o2 && r2) {
            var h2 = function(t3, e3) {
              return Pe("number" != typeof (t3 = "function" == typeof t3 ? t3(Object.assign({}, e3.rects, { placement: e3.placement })) : t3) ? t3 : Me(t3, Qt));
            }(s2.padding, i2), d2 = Ce(o2), u2 = "y" === l2 ? zt : Vt, f2 = "y" === l2 ? Rt : qt, p3 = i2.rects.reference[c3] + i2.rects.reference[l2] - r2[l2] - i2.rects.popper[c3], m2 = r2[l2] - i2.rects.reference[l2], g2 = $e(o2), _2 = g2 ? "y" === l2 ? g2.clientHeight || 0 : g2.clientWidth || 0 : 0, b2 = p3 / 2 - m2 / 2, v2 = h2[u2], y2 = _2 - d2[c3] - h2[f2], w2 = _2 / 2 - d2[c3] / 2 + b2, A2 = Ne(v2, w2, y2), E2 = l2;
            i2.modifiersData[n2] = ((e2 = {})[E2] = A2, e2.centerOffset = A2 - w2, e2);
          }
        }, effect: function(t2) {
          var e2 = t2.state, i2 = t2.options.element, n2 = void 0 === i2 ? "[data-popper-arrow]" : i2;
          null != n2 && ("string" != typeof n2 || (n2 = e2.elements.popper.querySelector(n2))) && Oe(e2.elements.popper, n2) && (e2.elements.arrow = n2);
        }, requires: ["popperOffsets"], requiresIfExists: ["preventOverflow"] };
        function Fe(t2) {
          return t2.split("-")[1];
        }
        var He = { top: "auto", right: "auto", bottom: "auto", left: "auto" };
        function We(t2) {
          var e2, i2 = t2.popper, n2 = t2.popperRect, s2 = t2.placement, o2 = t2.variation, r2 = t2.offsets, a2 = t2.position, l2 = t2.gpuAcceleration, c3 = t2.adaptive, h2 = t2.roundOffsets, d2 = t2.isFixed, u2 = r2.x, f2 = void 0 === u2 ? 0 : u2, p3 = r2.y, m2 = void 0 === p3 ? 0 : p3, g2 = "function" == typeof h2 ? h2({ x: f2, y: m2 }) : { x: f2, y: m2 };
          f2 = g2.x, m2 = g2.y;
          var _2 = r2.hasOwnProperty("x"), b2 = r2.hasOwnProperty("y"), v2 = Vt, y2 = zt, w2 = window;
          if (c3) {
            var A2 = $e(i2), E2 = "clientHeight", T2 = "clientWidth";
            A2 === fe(i2) && "static" !== xe(A2 = Le(i2)).position && "absolute" === a2 && (E2 = "scrollHeight", T2 = "scrollWidth"), (s2 === zt || (s2 === Vt || s2 === qt) && o2 === Yt) && (y2 = Rt, m2 -= (d2 && A2 === w2 && w2.visualViewport ? w2.visualViewport.height : A2[E2]) - n2.height, m2 *= l2 ? 1 : -1), s2 !== Vt && (s2 !== zt && s2 !== Rt || o2 !== Yt) || (v2 = qt, f2 -= (d2 && A2 === w2 && w2.visualViewport ? w2.visualViewport.width : A2[T2]) - n2.width, f2 *= l2 ? 1 : -1);
          }
          var C2, O2 = Object.assign({ position: a2 }, c3 && He), x2 = true === h2 ? function(t3, e3) {
            var i3 = t3.x, n3 = t3.y, s3 = e3.devicePixelRatio || 1;
            return { x: we(i3 * s3) / s3 || 0, y: we(n3 * s3) / s3 || 0 };
          }({ x: f2, y: m2 }, fe(i2)) : { x: f2, y: m2 };
          return f2 = x2.x, m2 = x2.y, l2 ? Object.assign({}, O2, ((C2 = {})[y2] = b2 ? "0" : "", C2[v2] = _2 ? "0" : "", C2.transform = (w2.devicePixelRatio || 1) <= 1 ? "translate(" + f2 + "px, " + m2 + "px)" : "translate3d(" + f2 + "px, " + m2 + "px, 0)", C2)) : Object.assign({}, O2, ((e2 = {})[y2] = b2 ? m2 + "px" : "", e2[v2] = _2 ? f2 + "px" : "", e2.transform = "", e2));
        }
        const Be = { name: "computeStyles", enabled: true, phase: "beforeWrite", fn: function(t2) {
          var e2 = t2.state, i2 = t2.options, n2 = i2.gpuAcceleration, s2 = void 0 === n2 || n2, o2 = i2.adaptive, r2 = void 0 === o2 || o2, a2 = i2.roundOffsets, l2 = void 0 === a2 || a2, c3 = { placement: be(e2.placement), variation: Fe(e2.placement), popper: e2.elements.popper, popperRect: e2.rects.popper, gpuAcceleration: s2, isFixed: "fixed" === e2.options.strategy };
          null != e2.modifiersData.popperOffsets && (e2.styles.popper = Object.assign({}, e2.styles.popper, We(Object.assign({}, c3, { offsets: e2.modifiersData.popperOffsets, position: e2.options.strategy, adaptive: r2, roundOffsets: l2 })))), null != e2.modifiersData.arrow && (e2.styles.arrow = Object.assign({}, e2.styles.arrow, We(Object.assign({}, c3, { offsets: e2.modifiersData.arrow, position: "absolute", adaptive: false, roundOffsets: l2 })))), e2.attributes.popper = Object.assign({}, e2.attributes.popper, { "data-popper-placement": e2.placement });
        }, data: {} };
        var ze = { passive: true };
        const Re = { name: "eventListeners", enabled: true, phase: "write", fn: function() {
        }, effect: function(t2) {
          var e2 = t2.state, i2 = t2.instance, n2 = t2.options, s2 = n2.scroll, o2 = void 0 === s2 || s2, r2 = n2.resize, a2 = void 0 === r2 || r2, l2 = fe(e2.elements.popper), c3 = [].concat(e2.scrollParents.reference, e2.scrollParents.popper);
          return o2 && c3.forEach(function(t3) {
            t3.addEventListener("scroll", i2.update, ze);
          }), a2 && l2.addEventListener("resize", i2.update, ze), function() {
            o2 && c3.forEach(function(t3) {
              t3.removeEventListener("scroll", i2.update, ze);
            }), a2 && l2.removeEventListener("resize", i2.update, ze);
          };
        }, data: {} };
        var qe = { left: "right", right: "left", bottom: "top", top: "bottom" };
        function Ve(t2) {
          return t2.replace(/left|right|bottom|top/g, function(t3) {
            return qe[t3];
          });
        }
        var Ke = { start: "end", end: "start" };
        function Qe(t2) {
          return t2.replace(/start|end/g, function(t3) {
            return Ke[t3];
          });
        }
        function Xe(t2) {
          var e2 = fe(t2);
          return { scrollLeft: e2.pageXOffset, scrollTop: e2.pageYOffset };
        }
        function Ye(t2) {
          return Te(Le(t2)).left + Xe(t2).scrollLeft;
        }
        function Ue(t2) {
          var e2 = xe(t2), i2 = e2.overflow, n2 = e2.overflowX, s2 = e2.overflowY;
          return /auto|scroll|overlay|hidden/.test(i2 + s2 + n2);
        }
        function Ge(t2) {
          return ["html", "body", "#document"].indexOf(ue(t2)) >= 0 ? t2.ownerDocument.body : me(t2) && Ue(t2) ? t2 : Ge(Se(t2));
        }
        function Je(t2, e2) {
          var i2;
          void 0 === e2 && (e2 = []);
          var n2 = Ge(t2), s2 = n2 === (null == (i2 = t2.ownerDocument) ? void 0 : i2.body), o2 = fe(n2), r2 = s2 ? [o2].concat(o2.visualViewport || [], Ue(n2) ? n2 : []) : n2, a2 = e2.concat(r2);
          return s2 ? a2 : a2.concat(Je(Se(r2)));
        }
        function Ze(t2) {
          return Object.assign({}, t2, { left: t2.x, top: t2.y, right: t2.x + t2.width, bottom: t2.y + t2.height });
        }
        function ti(t2, e2, i2) {
          return e2 === Gt ? Ze(function(t3, e3) {
            var i3 = fe(t3), n2 = Le(t3), s2 = i3.visualViewport, o2 = n2.clientWidth, r2 = n2.clientHeight, a2 = 0, l2 = 0;
            if (s2) {
              o2 = s2.width, r2 = s2.height;
              var c3 = Ee();
              (c3 || !c3 && "fixed" === e3) && (a2 = s2.offsetLeft, l2 = s2.offsetTop);
            }
            return { width: o2, height: r2, x: a2 + Ye(t3), y: l2 };
          }(t2, i2)) : pe(e2) ? function(t3, e3) {
            var i3 = Te(t3, false, "fixed" === e3);
            return i3.top = i3.top + t3.clientTop, i3.left = i3.left + t3.clientLeft, i3.bottom = i3.top + t3.clientHeight, i3.right = i3.left + t3.clientWidth, i3.width = t3.clientWidth, i3.height = t3.clientHeight, i3.x = i3.left, i3.y = i3.top, i3;
          }(e2, i2) : Ze(function(t3) {
            var e3, i3 = Le(t3), n2 = Xe(t3), s2 = null == (e3 = t3.ownerDocument) ? void 0 : e3.body, o2 = ve(i3.scrollWidth, i3.clientWidth, s2 ? s2.scrollWidth : 0, s2 ? s2.clientWidth : 0), r2 = ve(i3.scrollHeight, i3.clientHeight, s2 ? s2.scrollHeight : 0, s2 ? s2.clientHeight : 0), a2 = -n2.scrollLeft + Ye(t3), l2 = -n2.scrollTop;
            return "rtl" === xe(s2 || i3).direction && (a2 += ve(i3.clientWidth, s2 ? s2.clientWidth : 0) - o2), { width: o2, height: r2, x: a2, y: l2 };
          }(Le(t2)));
        }
        function ei(t2) {
          var e2, i2 = t2.reference, n2 = t2.element, s2 = t2.placement, o2 = s2 ? be(s2) : null, r2 = s2 ? Fe(s2) : null, a2 = i2.x + i2.width / 2 - n2.width / 2, l2 = i2.y + i2.height / 2 - n2.height / 2;
          switch (o2) {
            case zt:
              e2 = { x: a2, y: i2.y - n2.height };
              break;
            case Rt:
              e2 = { x: a2, y: i2.y + i2.height };
              break;
            case qt:
              e2 = { x: i2.x + i2.width, y: l2 };
              break;
            case Vt:
              e2 = { x: i2.x - n2.width, y: l2 };
              break;
            default:
              e2 = { x: i2.x, y: i2.y };
          }
          var c3 = o2 ? Ie(o2) : null;
          if (null != c3) {
            var h2 = "y" === c3 ? "height" : "width";
            switch (r2) {
              case Xt:
                e2[c3] = e2[c3] - (i2[h2] / 2 - n2[h2] / 2);
                break;
              case Yt:
                e2[c3] = e2[c3] + (i2[h2] / 2 - n2[h2] / 2);
            }
          }
          return e2;
        }
        function ii(t2, e2) {
          void 0 === e2 && (e2 = {});
          var i2 = e2, n2 = i2.placement, s2 = void 0 === n2 ? t2.placement : n2, o2 = i2.strategy, r2 = void 0 === o2 ? t2.strategy : o2, a2 = i2.boundary, l2 = void 0 === a2 ? Ut : a2, c3 = i2.rootBoundary, h2 = void 0 === c3 ? Gt : c3, d2 = i2.elementContext, u2 = void 0 === d2 ? Jt : d2, f2 = i2.altBoundary, p3 = void 0 !== f2 && f2, m2 = i2.padding, g2 = void 0 === m2 ? 0 : m2, _2 = Pe("number" != typeof g2 ? g2 : Me(g2, Qt)), b2 = u2 === Jt ? Zt : Jt, v2 = t2.rects.popper, y2 = t2.elements[p3 ? b2 : u2], w2 = function(t3, e3, i3, n3) {
            var s3 = "clippingParents" === e3 ? function(t4) {
              var e4 = Je(Se(t4)), i4 = ["absolute", "fixed"].indexOf(xe(t4).position) >= 0 && me(t4) ? $e(t4) : t4;
              return pe(i4) ? e4.filter(function(t5) {
                return pe(t5) && Oe(t5, i4) && "body" !== ue(t5);
              }) : [];
            }(t3) : [].concat(e3), o3 = [].concat(s3, [i3]), r3 = o3[0], a3 = o3.reduce(function(e4, i4) {
              var s4 = ti(t3, i4, n3);
              return e4.top = ve(s4.top, e4.top), e4.right = ye(s4.right, e4.right), e4.bottom = ye(s4.bottom, e4.bottom), e4.left = ve(s4.left, e4.left), e4;
            }, ti(t3, r3, n3));
            return a3.width = a3.right - a3.left, a3.height = a3.bottom - a3.top, a3.x = a3.left, a3.y = a3.top, a3;
          }(pe(y2) ? y2 : y2.contextElement || Le(t2.elements.popper), l2, h2, r2), A2 = Te(t2.elements.reference), E2 = ei({ reference: A2, element: v2, strategy: "absolute", placement: s2 }), T2 = Ze(Object.assign({}, v2, E2)), C2 = u2 === Jt ? T2 : A2, O2 = { top: w2.top - C2.top + _2.top, bottom: C2.bottom - w2.bottom + _2.bottom, left: w2.left - C2.left + _2.left, right: C2.right - w2.right + _2.right }, x2 = t2.modifiersData.offset;
          if (u2 === Jt && x2) {
            var k2 = x2[s2];
            Object.keys(O2).forEach(function(t3) {
              var e3 = [qt, Rt].indexOf(t3) >= 0 ? 1 : -1, i3 = [zt, Rt].indexOf(t3) >= 0 ? "y" : "x";
              O2[t3] += k2[i3] * e3;
            });
          }
          return O2;
        }
        function ni(t2, e2) {
          void 0 === e2 && (e2 = {});
          var i2 = e2, n2 = i2.placement, s2 = i2.boundary, o2 = i2.rootBoundary, r2 = i2.padding, a2 = i2.flipVariations, l2 = i2.allowedAutoPlacements, c3 = void 0 === l2 ? ee : l2, h2 = Fe(n2), d2 = h2 ? a2 ? te : te.filter(function(t3) {
            return Fe(t3) === h2;
          }) : Qt, u2 = d2.filter(function(t3) {
            return c3.indexOf(t3) >= 0;
          });
          0 === u2.length && (u2 = d2);
          var f2 = u2.reduce(function(e3, i3) {
            return e3[i3] = ii(t2, { placement: i3, boundary: s2, rootBoundary: o2, padding: r2 })[be(i3)], e3;
          }, {});
          return Object.keys(f2).sort(function(t3, e3) {
            return f2[t3] - f2[e3];
          });
        }
        const si = { name: "flip", enabled: true, phase: "main", fn: function(t2) {
          var e2 = t2.state, i2 = t2.options, n2 = t2.name;
          if (!e2.modifiersData[n2]._skip) {
            for (var s2 = i2.mainAxis, o2 = void 0 === s2 || s2, r2 = i2.altAxis, a2 = void 0 === r2 || r2, l2 = i2.fallbackPlacements, c3 = i2.padding, h2 = i2.boundary, d2 = i2.rootBoundary, u2 = i2.altBoundary, f2 = i2.flipVariations, p3 = void 0 === f2 || f2, m2 = i2.allowedAutoPlacements, g2 = e2.options.placement, _2 = be(g2), b2 = l2 || (_2 !== g2 && p3 ? function(t3) {
              if (be(t3) === Kt) return [];
              var e3 = Ve(t3);
              return [Qe(t3), e3, Qe(e3)];
            }(g2) : [Ve(g2)]), v2 = [g2].concat(b2).reduce(function(t3, i3) {
              return t3.concat(be(i3) === Kt ? ni(e2, { placement: i3, boundary: h2, rootBoundary: d2, padding: c3, flipVariations: p3, allowedAutoPlacements: m2 }) : i3);
            }, []), y2 = e2.rects.reference, w2 = e2.rects.popper, A2 = /* @__PURE__ */ new Map(), E2 = true, T2 = v2[0], C2 = 0; C2 < v2.length; C2++) {
              var O2 = v2[C2], x2 = be(O2), k2 = Fe(O2) === Xt, L2 = [zt, Rt].indexOf(x2) >= 0, S2 = L2 ? "width" : "height", D2 = ii(e2, { placement: O2, boundary: h2, rootBoundary: d2, altBoundary: u2, padding: c3 }), $3 = L2 ? k2 ? qt : Vt : k2 ? Rt : zt;
              y2[S2] > w2[S2] && ($3 = Ve($3));
              var I2 = Ve($3), N2 = [];
              if (o2 && N2.push(D2[x2] <= 0), a2 && N2.push(D2[$3] <= 0, D2[I2] <= 0), N2.every(function(t3) {
                return t3;
              })) {
                T2 = O2, E2 = false;
                break;
              }
              A2.set(O2, N2);
            }
            if (E2) for (var P2 = function(t3) {
              var e3 = v2.find(function(e4) {
                var i3 = A2.get(e4);
                if (i3) return i3.slice(0, t3).every(function(t4) {
                  return t4;
                });
              });
              if (e3) return T2 = e3, "break";
            }, M2 = p3 ? 3 : 1; M2 > 0 && "break" !== P2(M2); M2--) ;
            e2.placement !== T2 && (e2.modifiersData[n2]._skip = true, e2.placement = T2, e2.reset = true);
          }
        }, requiresIfExists: ["offset"], data: { _skip: false } };
        function oi(t2, e2, i2) {
          return void 0 === i2 && (i2 = { x: 0, y: 0 }), { top: t2.top - e2.height - i2.y, right: t2.right - e2.width + i2.x, bottom: t2.bottom - e2.height + i2.y, left: t2.left - e2.width - i2.x };
        }
        function ri(t2) {
          return [zt, qt, Rt, Vt].some(function(e2) {
            return t2[e2] >= 0;
          });
        }
        const ai = { name: "hide", enabled: true, phase: "main", requiresIfExists: ["preventOverflow"], fn: function(t2) {
          var e2 = t2.state, i2 = t2.name, n2 = e2.rects.reference, s2 = e2.rects.popper, o2 = e2.modifiersData.preventOverflow, r2 = ii(e2, { elementContext: "reference" }), a2 = ii(e2, { altBoundary: true }), l2 = oi(r2, n2), c3 = oi(a2, s2, o2), h2 = ri(l2), d2 = ri(c3);
          e2.modifiersData[i2] = { referenceClippingOffsets: l2, popperEscapeOffsets: c3, isReferenceHidden: h2, hasPopperEscaped: d2 }, e2.attributes.popper = Object.assign({}, e2.attributes.popper, { "data-popper-reference-hidden": h2, "data-popper-escaped": d2 });
        } }, li = { name: "offset", enabled: true, phase: "main", requires: ["popperOffsets"], fn: function(t2) {
          var e2 = t2.state, i2 = t2.options, n2 = t2.name, s2 = i2.offset, o2 = void 0 === s2 ? [0, 0] : s2, r2 = ee.reduce(function(t3, i3) {
            return t3[i3] = function(t4, e3, i4) {
              var n3 = be(t4), s3 = [Vt, zt].indexOf(n3) >= 0 ? -1 : 1, o3 = "function" == typeof i4 ? i4(Object.assign({}, e3, { placement: t4 })) : i4, r3 = o3[0], a3 = o3[1];
              return r3 = r3 || 0, a3 = (a3 || 0) * s3, [Vt, qt].indexOf(n3) >= 0 ? { x: a3, y: r3 } : { x: r3, y: a3 };
            }(i3, e2.rects, o2), t3;
          }, {}), a2 = r2[e2.placement], l2 = a2.x, c3 = a2.y;
          null != e2.modifiersData.popperOffsets && (e2.modifiersData.popperOffsets.x += l2, e2.modifiersData.popperOffsets.y += c3), e2.modifiersData[n2] = r2;
        } }, ci = { name: "popperOffsets", enabled: true, phase: "read", fn: function(t2) {
          var e2 = t2.state, i2 = t2.name;
          e2.modifiersData[i2] = ei({ reference: e2.rects.reference, element: e2.rects.popper, strategy: "absolute", placement: e2.placement });
        }, data: {} }, hi = { name: "preventOverflow", enabled: true, phase: "main", fn: function(t2) {
          var e2 = t2.state, i2 = t2.options, n2 = t2.name, s2 = i2.mainAxis, o2 = void 0 === s2 || s2, r2 = i2.altAxis, a2 = void 0 !== r2 && r2, l2 = i2.boundary, c3 = i2.rootBoundary, h2 = i2.altBoundary, d2 = i2.padding, u2 = i2.tether, f2 = void 0 === u2 || u2, p3 = i2.tetherOffset, m2 = void 0 === p3 ? 0 : p3, g2 = ii(e2, { boundary: l2, rootBoundary: c3, padding: d2, altBoundary: h2 }), _2 = be(e2.placement), b2 = Fe(e2.placement), v2 = !b2, y2 = Ie(_2), w2 = "x" === y2 ? "y" : "x", A2 = e2.modifiersData.popperOffsets, E2 = e2.rects.reference, T2 = e2.rects.popper, C2 = "function" == typeof m2 ? m2(Object.assign({}, e2.rects, { placement: e2.placement })) : m2, O2 = "number" == typeof C2 ? { mainAxis: C2, altAxis: C2 } : Object.assign({ mainAxis: 0, altAxis: 0 }, C2), x2 = e2.modifiersData.offset ? e2.modifiersData.offset[e2.placement] : null, k2 = { x: 0, y: 0 };
          if (A2) {
            if (o2) {
              var L2, S2 = "y" === y2 ? zt : Vt, D2 = "y" === y2 ? Rt : qt, $3 = "y" === y2 ? "height" : "width", I2 = A2[y2], N2 = I2 + g2[S2], P2 = I2 - g2[D2], M2 = f2 ? -T2[$3] / 2 : 0, j2 = b2 === Xt ? E2[$3] : T2[$3], F2 = b2 === Xt ? -T2[$3] : -E2[$3], H2 = e2.elements.arrow, W2 = f2 && H2 ? Ce(H2) : { width: 0, height: 0 }, B2 = e2.modifiersData["arrow#persistent"] ? e2.modifiersData["arrow#persistent"].padding : { top: 0, right: 0, bottom: 0, left: 0 }, z2 = B2[S2], R2 = B2[D2], q2 = Ne(0, E2[$3], W2[$3]), V2 = v2 ? E2[$3] / 2 - M2 - q2 - z2 - O2.mainAxis : j2 - q2 - z2 - O2.mainAxis, K2 = v2 ? -E2[$3] / 2 + M2 + q2 + R2 + O2.mainAxis : F2 + q2 + R2 + O2.mainAxis, Q2 = e2.elements.arrow && $e(e2.elements.arrow), X2 = Q2 ? "y" === y2 ? Q2.clientTop || 0 : Q2.clientLeft || 0 : 0, Y2 = null != (L2 = null == x2 ? void 0 : x2[y2]) ? L2 : 0, U2 = I2 + K2 - Y2, G2 = Ne(f2 ? ye(N2, I2 + V2 - Y2 - X2) : N2, I2, f2 ? ve(P2, U2) : P2);
              A2[y2] = G2, k2[y2] = G2 - I2;
            }
            if (a2) {
              var J2, Z2 = "x" === y2 ? zt : Vt, tt2 = "x" === y2 ? Rt : qt, et2 = A2[w2], it2 = "y" === w2 ? "height" : "width", nt2 = et2 + g2[Z2], st2 = et2 - g2[tt2], ot2 = -1 !== [zt, Vt].indexOf(_2), rt2 = null != (J2 = null == x2 ? void 0 : x2[w2]) ? J2 : 0, at2 = ot2 ? nt2 : et2 - E2[it2] - T2[it2] - rt2 + O2.altAxis, lt2 = ot2 ? et2 + E2[it2] + T2[it2] - rt2 - O2.altAxis : st2, ct2 = f2 && ot2 ? function(t3, e3, i3) {
                var n3 = Ne(t3, e3, i3);
                return n3 > i3 ? i3 : n3;
              }(at2, et2, lt2) : Ne(f2 ? at2 : nt2, et2, f2 ? lt2 : st2);
              A2[w2] = ct2, k2[w2] = ct2 - et2;
            }
            e2.modifiersData[n2] = k2;
          }
        }, requiresIfExists: ["offset"] };
        function di(t2, e2, i2) {
          void 0 === i2 && (i2 = false);
          var n2, s2, o2 = me(e2), r2 = me(e2) && function(t3) {
            var e3 = t3.getBoundingClientRect(), i3 = we(e3.width) / t3.offsetWidth || 1, n3 = we(e3.height) / t3.offsetHeight || 1;
            return 1 !== i3 || 1 !== n3;
          }(e2), a2 = Le(e2), l2 = Te(t2, r2, i2), c3 = { scrollLeft: 0, scrollTop: 0 }, h2 = { x: 0, y: 0 };
          return (o2 || !o2 && !i2) && (("body" !== ue(e2) || Ue(a2)) && (c3 = (n2 = e2) !== fe(n2) && me(n2) ? { scrollLeft: (s2 = n2).scrollLeft, scrollTop: s2.scrollTop } : Xe(n2)), me(e2) ? ((h2 = Te(e2, true)).x += e2.clientLeft, h2.y += e2.clientTop) : a2 && (h2.x = Ye(a2))), { x: l2.left + c3.scrollLeft - h2.x, y: l2.top + c3.scrollTop - h2.y, width: l2.width, height: l2.height };
        }
        function ui(t2) {
          var e2 = /* @__PURE__ */ new Map(), i2 = /* @__PURE__ */ new Set(), n2 = [];
          function s2(t3) {
            i2.add(t3.name), [].concat(t3.requires || [], t3.requiresIfExists || []).forEach(function(t4) {
              if (!i2.has(t4)) {
                var n3 = e2.get(t4);
                n3 && s2(n3);
              }
            }), n2.push(t3);
          }
          return t2.forEach(function(t3) {
            e2.set(t3.name, t3);
          }), t2.forEach(function(t3) {
            i2.has(t3.name) || s2(t3);
          }), n2;
        }
        var fi = { placement: "bottom", modifiers: [], strategy: "absolute" };
        function pi() {
          for (var t2 = arguments.length, e2 = new Array(t2), i2 = 0; i2 < t2; i2++) e2[i2] = arguments[i2];
          return !e2.some(function(t3) {
            return !(t3 && "function" == typeof t3.getBoundingClientRect);
          });
        }
        function mi(t2) {
          void 0 === t2 && (t2 = {});
          var e2 = t2, i2 = e2.defaultModifiers, n2 = void 0 === i2 ? [] : i2, s2 = e2.defaultOptions, o2 = void 0 === s2 ? fi : s2;
          return function(t3, e3, i3) {
            void 0 === i3 && (i3 = o2);
            var s3, r2, a2 = { placement: "bottom", orderedModifiers: [], options: Object.assign({}, fi, o2), modifiersData: {}, elements: { reference: t3, popper: e3 }, attributes: {}, styles: {} }, l2 = [], c3 = false, h2 = { state: a2, setOptions: function(i4) {
              var s4 = "function" == typeof i4 ? i4(a2.options) : i4;
              d2(), a2.options = Object.assign({}, o2, a2.options, s4), a2.scrollParents = { reference: pe(t3) ? Je(t3) : t3.contextElement ? Je(t3.contextElement) : [], popper: Je(e3) };
              var r3, c4, u2 = function(t4) {
                var e4 = ui(t4);
                return de.reduce(function(t5, i5) {
                  return t5.concat(e4.filter(function(t6) {
                    return t6.phase === i5;
                  }));
                }, []);
              }((r3 = [].concat(n2, a2.options.modifiers), c4 = r3.reduce(function(t4, e4) {
                var i5 = t4[e4.name];
                return t4[e4.name] = i5 ? Object.assign({}, i5, e4, { options: Object.assign({}, i5.options, e4.options), data: Object.assign({}, i5.data, e4.data) }) : e4, t4;
              }, {}), Object.keys(c4).map(function(t4) {
                return c4[t4];
              })));
              return a2.orderedModifiers = u2.filter(function(t4) {
                return t4.enabled;
              }), a2.orderedModifiers.forEach(function(t4) {
                var e4 = t4.name, i5 = t4.options, n3 = void 0 === i5 ? {} : i5, s5 = t4.effect;
                if ("function" == typeof s5) {
                  var o3 = s5({ state: a2, name: e4, instance: h2, options: n3 });
                  l2.push(o3 || function() {
                  });
                }
              }), h2.update();
            }, forceUpdate: function() {
              if (!c3) {
                var t4 = a2.elements, e4 = t4.reference, i4 = t4.popper;
                if (pi(e4, i4)) {
                  a2.rects = { reference: di(e4, $e(i4), "fixed" === a2.options.strategy), popper: Ce(i4) }, a2.reset = false, a2.placement = a2.options.placement, a2.orderedModifiers.forEach(function(t5) {
                    return a2.modifiersData[t5.name] = Object.assign({}, t5.data);
                  });
                  for (var n3 = 0; n3 < a2.orderedModifiers.length; n3++) if (true !== a2.reset) {
                    var s4 = a2.orderedModifiers[n3], o3 = s4.fn, r3 = s4.options, l3 = void 0 === r3 ? {} : r3, d3 = s4.name;
                    "function" == typeof o3 && (a2 = o3({ state: a2, options: l3, name: d3, instance: h2 }) || a2);
                  } else a2.reset = false, n3 = -1;
                }
              }
            }, update: (s3 = function() {
              return new Promise(function(t4) {
                h2.forceUpdate(), t4(a2);
              });
            }, function() {
              return r2 || (r2 = new Promise(function(t4) {
                Promise.resolve().then(function() {
                  r2 = void 0, t4(s3());
                });
              })), r2;
            }), destroy: function() {
              d2(), c3 = true;
            } };
            if (!pi(t3, e3)) return h2;
            function d2() {
              l2.forEach(function(t4) {
                return t4();
              }), l2 = [];
            }
            return h2.setOptions(i3).then(function(t4) {
              !c3 && i3.onFirstUpdate && i3.onFirstUpdate(t4);
            }), h2;
          };
        }
        var gi = mi(), _i = mi({ defaultModifiers: [Re, ci, Be, _e] }), bi = mi({ defaultModifiers: [Re, ci, Be, _e, li, si, hi, je, ai] });
        const vi = Object.freeze(Object.defineProperty({ __proto__: null, afterMain: ae, afterRead: se, afterWrite: he, applyStyles: _e, arrow: je, auto: Kt, basePlacements: Qt, beforeMain: oe, beforeRead: ie, beforeWrite: le, bottom: Rt, clippingParents: Ut, computeStyles: Be, createPopper: bi, createPopperBase: gi, createPopperLite: _i, detectOverflow: ii, end: Yt, eventListeners: Re, flip: si, hide: ai, left: Vt, main: re, modifierPhases: de, offset: li, placements: ee, popper: Jt, popperGenerator: mi, popperOffsets: ci, preventOverflow: hi, read: ne, reference: Zt, right: qt, start: Xt, top: zt, variationPlacements: te, viewport: Gt, write: ce }, Symbol.toStringTag, { value: "Module" })), yi = "dropdown", wi = ".bs.dropdown", Ai = ".data-api", Ei = "ArrowUp", Ti = "ArrowDown", Ci = `hide${wi}`, Oi = `hidden${wi}`, xi = `show${wi}`, ki = `shown${wi}`, Li = `click${wi}${Ai}`, Si = `keydown${wi}${Ai}`, Di = `keyup${wi}${Ai}`, $i = "show", Ii = '[data-bs-toggle="dropdown"]:not(.disabled):not(:disabled)', Ni = `${Ii}.${$i}`, Pi = ".dropdown-menu", Mi = p2() ? "top-end" : "top-start", ji = p2() ? "top-start" : "top-end", Fi = p2() ? "bottom-end" : "bottom-start", Hi = p2() ? "bottom-start" : "bottom-end", Wi = p2() ? "left-start" : "right-start", Bi = p2() ? "right-start" : "left-start", zi = { autoClose: true, boundary: "clippingParents", display: "dynamic", offset: [0, 2], popperConfig: null, reference: "toggle" }, Ri = { autoClose: "(boolean|string)", boundary: "(string|element)", display: "string", offset: "(array|string|function)", popperConfig: "(null|object|function)", reference: "(string|element|object)" };
        class qi extends W {
          constructor(t2, e2) {
            super(t2, e2), this._popper = null, this._parent = this._element.parentNode, this._menu = z.next(this._element, Pi)[0] || z.prev(this._element, Pi)[0] || z.findOne(Pi, this._parent), this._inNavbar = this._detectNavbar();
          }
          static get Default() {
            return zi;
          }
          static get DefaultType() {
            return Ri;
          }
          static get NAME() {
            return yi;
          }
          toggle() {
            return this._isShown() ? this.hide() : this.show();
          }
          show() {
            if (l(this._element) || this._isShown()) return;
            const t2 = { relatedTarget: this._element };
            if (!N.trigger(this._element, xi, t2).defaultPrevented) {
              if (this._createPopper(), "ontouchstart" in document.documentElement && !this._parent.closest(".navbar-nav")) for (const t3 of [].concat(...document.body.children)) N.on(t3, "mouseover", h);
              this._element.focus(), this._element.setAttribute("aria-expanded", true), this._menu.classList.add($i), this._element.classList.add($i), N.trigger(this._element, ki, t2);
            }
          }
          hide() {
            if (l(this._element) || !this._isShown()) return;
            const t2 = { relatedTarget: this._element };
            this._completeHide(t2);
          }
          dispose() {
            this._popper && this._popper.destroy(), super.dispose();
          }
          update() {
            this._inNavbar = this._detectNavbar(), this._popper && this._popper.update();
          }
          _completeHide(t2) {
            if (!N.trigger(this._element, Ci, t2).defaultPrevented) {
              if ("ontouchstart" in document.documentElement) for (const t3 of [].concat(...document.body.children)) N.off(t3, "mouseover", h);
              this._popper && this._popper.destroy(), this._menu.classList.remove($i), this._element.classList.remove($i), this._element.setAttribute("aria-expanded", "false"), F.removeDataAttribute(this._menu, "popper"), N.trigger(this._element, Oi, t2);
            }
          }
          _getConfig(t2) {
            if ("object" == typeof (t2 = super._getConfig(t2)).reference && !o(t2.reference) && "function" != typeof t2.reference.getBoundingClientRect) throw new TypeError(`${yi.toUpperCase()}: Option "reference" provided type "object" without a required "getBoundingClientRect" method.`);
            return t2;
          }
          _createPopper() {
            if (void 0 === vi) throw new TypeError("Bootstrap's dropdowns require Popper (https://popper.js.org)");
            let t2 = this._element;
            "parent" === this._config.reference ? t2 = this._parent : o(this._config.reference) ? t2 = r(this._config.reference) : "object" == typeof this._config.reference && (t2 = this._config.reference);
            const e2 = this._getPopperConfig();
            this._popper = bi(t2, this._menu, e2);
          }
          _isShown() {
            return this._menu.classList.contains($i);
          }
          _getPlacement() {
            const t2 = this._parent;
            if (t2.classList.contains("dropend")) return Wi;
            if (t2.classList.contains("dropstart")) return Bi;
            if (t2.classList.contains("dropup-center")) return "top";
            if (t2.classList.contains("dropdown-center")) return "bottom";
            const e2 = "end" === getComputedStyle(this._menu).getPropertyValue("--bs-position").trim();
            return t2.classList.contains("dropup") ? e2 ? ji : Mi : e2 ? Hi : Fi;
          }
          _detectNavbar() {
            return null !== this._element.closest(".navbar");
          }
          _getOffset() {
            const { offset: t2 } = this._config;
            return "string" == typeof t2 ? t2.split(",").map((t3) => Number.parseInt(t3, 10)) : "function" == typeof t2 ? (e2) => t2(e2, this._element) : t2;
          }
          _getPopperConfig() {
            const t2 = { placement: this._getPlacement(), modifiers: [{ name: "preventOverflow", options: { boundary: this._config.boundary } }, { name: "offset", options: { offset: this._getOffset() } }] };
            return (this._inNavbar || "static" === this._config.display) && (F.setDataAttribute(this._menu, "popper", "static"), t2.modifiers = [{ name: "applyStyles", enabled: false }]), { ...t2, ...g(this._config.popperConfig, [t2]) };
          }
          _selectMenuItem({ key: t2, target: e2 }) {
            const i2 = z.find(".dropdown-menu .dropdown-item:not(.disabled):not(:disabled)", this._menu).filter((t3) => a(t3));
            i2.length && b(i2, e2, t2 === Ti, !i2.includes(e2)).focus();
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = qi.getOrCreateInstance(this, t2);
              if ("string" == typeof t2) {
                if (void 0 === e2[t2]) throw new TypeError(`No method named "${t2}"`);
                e2[t2]();
              }
            });
          }
          static clearMenus(t2) {
            if (2 === t2.button || "keyup" === t2.type && "Tab" !== t2.key) return;
            const e2 = z.find(Ni);
            for (const i2 of e2) {
              const e3 = qi.getInstance(i2);
              if (!e3 || false === e3._config.autoClose) continue;
              const n2 = t2.composedPath(), s2 = n2.includes(e3._menu);
              if (n2.includes(e3._element) || "inside" === e3._config.autoClose && !s2 || "outside" === e3._config.autoClose && s2) continue;
              if (e3._menu.contains(t2.target) && ("keyup" === t2.type && "Tab" === t2.key || /input|select|option|textarea|form/i.test(t2.target.tagName))) continue;
              const o2 = { relatedTarget: e3._element };
              "click" === t2.type && (o2.clickEvent = t2), e3._completeHide(o2);
            }
          }
          static dataApiKeydownHandler(t2) {
            const e2 = /input|textarea/i.test(t2.target.tagName), i2 = "Escape" === t2.key, n2 = [Ei, Ti].includes(t2.key);
            if (!n2 && !i2) return;
            if (e2 && !i2) return;
            t2.preventDefault();
            const s2 = this.matches(Ii) ? this : z.prev(this, Ii)[0] || z.next(this, Ii)[0] || z.findOne(Ii, t2.delegateTarget.parentNode), o2 = qi.getOrCreateInstance(s2);
            if (n2) return t2.stopPropagation(), o2.show(), void o2._selectMenuItem(t2);
            o2._isShown() && (t2.stopPropagation(), o2.hide(), s2.focus());
          }
        }
        N.on(document, Si, Ii, qi.dataApiKeydownHandler), N.on(document, Si, Pi, qi.dataApiKeydownHandler), N.on(document, Li, qi.clearMenus), N.on(document, Di, qi.clearMenus), N.on(document, Li, Ii, function(t2) {
          t2.preventDefault(), qi.getOrCreateInstance(this).toggle();
        }), m(qi);
        const Vi = "backdrop", Ki = "show", Qi = `mousedown.bs.${Vi}`, Xi = { className: "modal-backdrop", clickCallback: null, isAnimated: false, isVisible: true, rootElement: "body" }, Yi = { className: "string", clickCallback: "(function|null)", isAnimated: "boolean", isVisible: "boolean", rootElement: "(element|string)" };
        class Ui extends H {
          constructor(t2) {
            super(), this._config = this._getConfig(t2), this._isAppended = false, this._element = null;
          }
          static get Default() {
            return Xi;
          }
          static get DefaultType() {
            return Yi;
          }
          static get NAME() {
            return Vi;
          }
          show(t2) {
            if (!this._config.isVisible) return void g(t2);
            this._append();
            const e2 = this._getElement();
            this._config.isAnimated && d(e2), e2.classList.add(Ki), this._emulateAnimation(() => {
              g(t2);
            });
          }
          hide(t2) {
            this._config.isVisible ? (this._getElement().classList.remove(Ki), this._emulateAnimation(() => {
              this.dispose(), g(t2);
            })) : g(t2);
          }
          dispose() {
            this._isAppended && (N.off(this._element, Qi), this._element.remove(), this._isAppended = false);
          }
          _getElement() {
            if (!this._element) {
              const t2 = document.createElement("div");
              t2.className = this._config.className, this._config.isAnimated && t2.classList.add("fade"), this._element = t2;
            }
            return this._element;
          }
          _configAfterMerge(t2) {
            return t2.rootElement = r(t2.rootElement), t2;
          }
          _append() {
            if (this._isAppended) return;
            const t2 = this._getElement();
            this._config.rootElement.append(t2), N.on(t2, Qi, () => {
              g(this._config.clickCallback);
            }), this._isAppended = true;
          }
          _emulateAnimation(t2) {
            _(t2, this._getElement(), this._config.isAnimated);
          }
        }
        const Gi = ".bs.focustrap", Ji = `focusin${Gi}`, Zi = `keydown.tab${Gi}`, tn = "backward", en = { autofocus: true, trapElement: null }, nn = { autofocus: "boolean", trapElement: "element" };
        class sn extends H {
          constructor(t2) {
            super(), this._config = this._getConfig(t2), this._isActive = false, this._lastTabNavDirection = null;
          }
          static get Default() {
            return en;
          }
          static get DefaultType() {
            return nn;
          }
          static get NAME() {
            return "focustrap";
          }
          activate() {
            this._isActive || (this._config.autofocus && this._config.trapElement.focus(), N.off(document, Gi), N.on(document, Ji, (t2) => this._handleFocusin(t2)), N.on(document, Zi, (t2) => this._handleKeydown(t2)), this._isActive = true);
          }
          deactivate() {
            this._isActive && (this._isActive = false, N.off(document, Gi));
          }
          _handleFocusin(t2) {
            const { trapElement: e2 } = this._config;
            if (t2.target === document || t2.target === e2 || e2.contains(t2.target)) return;
            const i2 = z.focusableChildren(e2);
            0 === i2.length ? e2.focus() : this._lastTabNavDirection === tn ? i2[i2.length - 1].focus() : i2[0].focus();
          }
          _handleKeydown(t2) {
            "Tab" === t2.key && (this._lastTabNavDirection = t2.shiftKey ? tn : "forward");
          }
        }
        const on = ".fixed-top, .fixed-bottom, .is-fixed, .sticky-top", rn = ".sticky-top", an = "padding-right", ln = "margin-right";
        class cn {
          constructor() {
            this._element = document.body;
          }
          getWidth() {
            const t2 = document.documentElement.clientWidth;
            return Math.abs(window.innerWidth - t2);
          }
          hide() {
            const t2 = this.getWidth();
            this._disableOverFlow(), this._setElementAttributes(this._element, an, (e2) => e2 + t2), this._setElementAttributes(on, an, (e2) => e2 + t2), this._setElementAttributes(rn, ln, (e2) => e2 - t2);
          }
          reset() {
            this._resetElementAttributes(this._element, "overflow"), this._resetElementAttributes(this._element, an), this._resetElementAttributes(on, an), this._resetElementAttributes(rn, ln);
          }
          isOverflowing() {
            return this.getWidth() > 0;
          }
          _disableOverFlow() {
            this._saveInitialAttribute(this._element, "overflow"), this._element.style.overflow = "hidden";
          }
          _setElementAttributes(t2, e2, i2) {
            const n2 = this.getWidth();
            this._applyManipulationCallback(t2, (t3) => {
              if (t3 !== this._element && window.innerWidth > t3.clientWidth + n2) return;
              this._saveInitialAttribute(t3, e2);
              const s2 = window.getComputedStyle(t3).getPropertyValue(e2);
              t3.style.setProperty(e2, `${i2(Number.parseFloat(s2))}px`);
            });
          }
          _saveInitialAttribute(t2, e2) {
            const i2 = t2.style.getPropertyValue(e2);
            i2 && F.setDataAttribute(t2, e2, i2);
          }
          _resetElementAttributes(t2, e2) {
            this._applyManipulationCallback(t2, (t3) => {
              const i2 = F.getDataAttribute(t3, e2);
              null !== i2 ? (F.removeDataAttribute(t3, e2), t3.style.setProperty(e2, i2)) : t3.style.removeProperty(e2);
            });
          }
          _applyManipulationCallback(t2, e2) {
            if (o(t2)) e2(t2);
            else for (const i2 of z.find(t2, this._element)) e2(i2);
          }
        }
        const hn = ".bs.modal", dn = `hide${hn}`, un = `hidePrevented${hn}`, fn = `hidden${hn}`, pn = `show${hn}`, mn = `shown${hn}`, gn = `resize${hn}`, _n = `click.dismiss${hn}`, bn = `mousedown.dismiss${hn}`, vn = `keydown.dismiss${hn}`, yn = `click${hn}.data-api`, wn = "modal-open", An = "show", En = "modal-static", Tn = { backdrop: true, focus: true, keyboard: true }, Cn = { backdrop: "(boolean|string)", focus: "boolean", keyboard: "boolean" };
        class On extends W {
          constructor(t2, e2) {
            super(t2, e2), this._dialog = z.findOne(".modal-dialog", this._element), this._backdrop = this._initializeBackDrop(), this._focustrap = this._initializeFocusTrap(), this._isShown = false, this._isTransitioning = false, this._scrollBar = new cn(), this._addEventListeners();
          }
          static get Default() {
            return Tn;
          }
          static get DefaultType() {
            return Cn;
          }
          static get NAME() {
            return "modal";
          }
          toggle(t2) {
            return this._isShown ? this.hide() : this.show(t2);
          }
          show(t2) {
            this._isShown || this._isTransitioning || N.trigger(this._element, pn, { relatedTarget: t2 }).defaultPrevented || (this._isShown = true, this._isTransitioning = true, this._scrollBar.hide(), document.body.classList.add(wn), this._adjustDialog(), this._backdrop.show(() => this._showElement(t2)));
          }
          hide() {
            this._isShown && !this._isTransitioning && (N.trigger(this._element, dn).defaultPrevented || (this._isShown = false, this._isTransitioning = true, this._focustrap.deactivate(), this._element.classList.remove(An), this._queueCallback(() => this._hideModal(), this._element, this._isAnimated())));
          }
          dispose() {
            N.off(window, hn), N.off(this._dialog, hn), this._backdrop.dispose(), this._focustrap.deactivate(), super.dispose();
          }
          handleUpdate() {
            this._adjustDialog();
          }
          _initializeBackDrop() {
            return new Ui({ isVisible: Boolean(this._config.backdrop), isAnimated: this._isAnimated() });
          }
          _initializeFocusTrap() {
            return new sn({ trapElement: this._element });
          }
          _showElement(t2) {
            document.body.contains(this._element) || document.body.append(this._element), this._element.style.display = "block", this._element.removeAttribute("aria-hidden"), this._element.setAttribute("aria-modal", true), this._element.setAttribute("role", "dialog"), this._element.scrollTop = 0;
            const e2 = z.findOne(".modal-body", this._dialog);
            e2 && (e2.scrollTop = 0), d(this._element), this._element.classList.add(An), this._queueCallback(() => {
              this._config.focus && this._focustrap.activate(), this._isTransitioning = false, N.trigger(this._element, mn, { relatedTarget: t2 });
            }, this._dialog, this._isAnimated());
          }
          _addEventListeners() {
            N.on(this._element, vn, (t2) => {
              "Escape" === t2.key && (this._config.keyboard ? this.hide() : this._triggerBackdropTransition());
            }), N.on(window, gn, () => {
              this._isShown && !this._isTransitioning && this._adjustDialog();
            }), N.on(this._element, bn, (t2) => {
              N.one(this._element, _n, (e2) => {
                this._element === t2.target && this._element === e2.target && ("static" !== this._config.backdrop ? this._config.backdrop && this.hide() : this._triggerBackdropTransition());
              });
            });
          }
          _hideModal() {
            this._element.style.display = "none", this._element.setAttribute("aria-hidden", true), this._element.removeAttribute("aria-modal"), this._element.removeAttribute("role"), this._isTransitioning = false, this._backdrop.hide(() => {
              document.body.classList.remove(wn), this._resetAdjustments(), this._scrollBar.reset(), N.trigger(this._element, fn);
            });
          }
          _isAnimated() {
            return this._element.classList.contains("fade");
          }
          _triggerBackdropTransition() {
            if (N.trigger(this._element, un).defaultPrevented) return;
            const t2 = this._element.scrollHeight > document.documentElement.clientHeight, e2 = this._element.style.overflowY;
            "hidden" === e2 || this._element.classList.contains(En) || (t2 || (this._element.style.overflowY = "hidden"), this._element.classList.add(En), this._queueCallback(() => {
              this._element.classList.remove(En), this._queueCallback(() => {
                this._element.style.overflowY = e2;
              }, this._dialog);
            }, this._dialog), this._element.focus());
          }
          _adjustDialog() {
            const t2 = this._element.scrollHeight > document.documentElement.clientHeight, e2 = this._scrollBar.getWidth(), i2 = e2 > 0;
            if (i2 && !t2) {
              const t3 = p2() ? "paddingLeft" : "paddingRight";
              this._element.style[t3] = `${e2}px`;
            }
            if (!i2 && t2) {
              const t3 = p2() ? "paddingRight" : "paddingLeft";
              this._element.style[t3] = `${e2}px`;
            }
          }
          _resetAdjustments() {
            this._element.style.paddingLeft = "", this._element.style.paddingRight = "";
          }
          static jQueryInterface(t2, e2) {
            return this.each(function() {
              const i2 = On.getOrCreateInstance(this, t2);
              if ("string" == typeof t2) {
                if (void 0 === i2[t2]) throw new TypeError(`No method named "${t2}"`);
                i2[t2](e2);
              }
            });
          }
        }
        N.on(document, yn, '[data-bs-toggle="modal"]', function(t2) {
          const e2 = z.getElementFromSelector(this);
          ["A", "AREA"].includes(this.tagName) && t2.preventDefault(), N.one(e2, pn, (t3) => {
            t3.defaultPrevented || N.one(e2, fn, () => {
              a(this) && this.focus();
            });
          });
          const i2 = z.findOne(".modal.show");
          i2 && On.getInstance(i2).hide(), On.getOrCreateInstance(e2).toggle(this);
        }), R(On), m(On);
        const xn = ".bs.offcanvas", kn = ".data-api", Ln = `load${xn}${kn}`, Sn = "show", Dn = "showing", $n = "hiding", In = ".offcanvas.show", Nn = `show${xn}`, Pn = `shown${xn}`, Mn = `hide${xn}`, jn = `hidePrevented${xn}`, Fn = `hidden${xn}`, Hn = `resize${xn}`, Wn = `click${xn}${kn}`, Bn = `keydown.dismiss${xn}`, zn = { backdrop: true, keyboard: true, scroll: false }, Rn = { backdrop: "(boolean|string)", keyboard: "boolean", scroll: "boolean" };
        class qn extends W {
          constructor(t2, e2) {
            super(t2, e2), this._isShown = false, this._backdrop = this._initializeBackDrop(), this._focustrap = this._initializeFocusTrap(), this._addEventListeners();
          }
          static get Default() {
            return zn;
          }
          static get DefaultType() {
            return Rn;
          }
          static get NAME() {
            return "offcanvas";
          }
          toggle(t2) {
            return this._isShown ? this.hide() : this.show(t2);
          }
          show(t2) {
            this._isShown || N.trigger(this._element, Nn, { relatedTarget: t2 }).defaultPrevented || (this._isShown = true, this._backdrop.show(), this._config.scroll || new cn().hide(), this._element.setAttribute("aria-modal", true), this._element.setAttribute("role", "dialog"), this._element.classList.add(Dn), this._queueCallback(() => {
              this._config.scroll && !this._config.backdrop || this._focustrap.activate(), this._element.classList.add(Sn), this._element.classList.remove(Dn), N.trigger(this._element, Pn, { relatedTarget: t2 });
            }, this._element, true));
          }
          hide() {
            this._isShown && (N.trigger(this._element, Mn).defaultPrevented || (this._focustrap.deactivate(), this._element.blur(), this._isShown = false, this._element.classList.add($n), this._backdrop.hide(), this._queueCallback(() => {
              this._element.classList.remove(Sn, $n), this._element.removeAttribute("aria-modal"), this._element.removeAttribute("role"), this._config.scroll || new cn().reset(), N.trigger(this._element, Fn);
            }, this._element, true)));
          }
          dispose() {
            this._backdrop.dispose(), this._focustrap.deactivate(), super.dispose();
          }
          _initializeBackDrop() {
            const t2 = Boolean(this._config.backdrop);
            return new Ui({ className: "offcanvas-backdrop", isVisible: t2, isAnimated: true, rootElement: this._element.parentNode, clickCallback: t2 ? () => {
              "static" !== this._config.backdrop ? this.hide() : N.trigger(this._element, jn);
            } : null });
          }
          _initializeFocusTrap() {
            return new sn({ trapElement: this._element });
          }
          _addEventListeners() {
            N.on(this._element, Bn, (t2) => {
              "Escape" === t2.key && (this._config.keyboard ? this.hide() : N.trigger(this._element, jn));
            });
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = qn.getOrCreateInstance(this, t2);
              if ("string" == typeof t2) {
                if (void 0 === e2[t2] || t2.startsWith("_") || "constructor" === t2) throw new TypeError(`No method named "${t2}"`);
                e2[t2](this);
              }
            });
          }
        }
        N.on(document, Wn, '[data-bs-toggle="offcanvas"]', function(t2) {
          const e2 = z.getElementFromSelector(this);
          if (["A", "AREA"].includes(this.tagName) && t2.preventDefault(), l(this)) return;
          N.one(e2, Fn, () => {
            a(this) && this.focus();
          });
          const i2 = z.findOne(In);
          i2 && i2 !== e2 && qn.getInstance(i2).hide(), qn.getOrCreateInstance(e2).toggle(this);
        }), N.on(window, Ln, () => {
          for (const t2 of z.find(In)) qn.getOrCreateInstance(t2).show();
        }), N.on(window, Hn, () => {
          for (const t2 of z.find("[aria-modal][class*=show][class*=offcanvas-]")) "fixed" !== getComputedStyle(t2).position && qn.getOrCreateInstance(t2).hide();
        }), R(qn), m(qn);
        const Vn = { "*": ["class", "dir", "id", "lang", "role", /^aria-[\w-]*$/i], a: ["target", "href", "title", "rel"], area: [], b: [], br: [], col: [], code: [], div: [], em: [], hr: [], h1: [], h2: [], h3: [], h4: [], h5: [], h6: [], i: [], img: ["src", "srcset", "alt", "title", "width", "height"], li: [], ol: [], p: [], pre: [], s: [], small: [], span: [], sub: [], sup: [], strong: [], u: [], ul: [] }, Kn = /* @__PURE__ */ new Set(["background", "cite", "href", "itemtype", "longdesc", "poster", "src", "xlink:href"]), Qn = /^(?!javascript:)(?:[a-z0-9+.-]+:|[^&:/?#]*(?:[/?#]|$))/i, Xn = (t2, e2) => {
          const i2 = t2.nodeName.toLowerCase();
          return e2.includes(i2) ? !Kn.has(i2) || Boolean(Qn.test(t2.nodeValue)) : e2.filter((t3) => t3 instanceof RegExp).some((t3) => t3.test(i2));
        }, Yn = { allowList: Vn, content: {}, extraClass: "", html: false, sanitize: true, sanitizeFn: null, template: "<div></div>" }, Un = { allowList: "object", content: "object", extraClass: "(string|function)", html: "boolean", sanitize: "boolean", sanitizeFn: "(null|function)", template: "string" }, Gn = { entry: "(string|element|function|null)", selector: "(string|element)" };
        class Jn extends H {
          constructor(t2) {
            super(), this._config = this._getConfig(t2);
          }
          static get Default() {
            return Yn;
          }
          static get DefaultType() {
            return Un;
          }
          static get NAME() {
            return "TemplateFactory";
          }
          getContent() {
            return Object.values(this._config.content).map((t2) => this._resolvePossibleFunction(t2)).filter(Boolean);
          }
          hasContent() {
            return this.getContent().length > 0;
          }
          changeContent(t2) {
            return this._checkContent(t2), this._config.content = { ...this._config.content, ...t2 }, this;
          }
          toHtml() {
            const t2 = document.createElement("div");
            t2.innerHTML = this._maybeSanitize(this._config.template);
            for (const [e3, i3] of Object.entries(this._config.content)) this._setContent(t2, i3, e3);
            const e2 = t2.children[0], i2 = this._resolvePossibleFunction(this._config.extraClass);
            return i2 && e2.classList.add(...i2.split(" ")), e2;
          }
          _typeCheckConfig(t2) {
            super._typeCheckConfig(t2), this._checkContent(t2.content);
          }
          _checkContent(t2) {
            for (const [e2, i2] of Object.entries(t2)) super._typeCheckConfig({ selector: e2, entry: i2 }, Gn);
          }
          _setContent(t2, e2, i2) {
            const n2 = z.findOne(i2, t2);
            n2 && ((e2 = this._resolvePossibleFunction(e2)) ? o(e2) ? this._putElementInTemplate(r(e2), n2) : this._config.html ? n2.innerHTML = this._maybeSanitize(e2) : n2.textContent = e2 : n2.remove());
          }
          _maybeSanitize(t2) {
            return this._config.sanitize ? function(t3, e2, i2) {
              if (!t3.length) return t3;
              if (i2 && "function" == typeof i2) return i2(t3);
              const n2 = new window.DOMParser().parseFromString(t3, "text/html"), s2 = [].concat(...n2.body.querySelectorAll("*"));
              for (const t4 of s2) {
                const i3 = t4.nodeName.toLowerCase();
                if (!Object.keys(e2).includes(i3)) {
                  t4.remove();
                  continue;
                }
                const n3 = [].concat(...t4.attributes), s3 = [].concat(e2["*"] || [], e2[i3] || []);
                for (const e3 of n3) Xn(e3, s3) || t4.removeAttribute(e3.nodeName);
              }
              return n2.body.innerHTML;
            }(t2, this._config.allowList, this._config.sanitizeFn) : t2;
          }
          _resolvePossibleFunction(t2) {
            return g(t2, [this]);
          }
          _putElementInTemplate(t2, e2) {
            if (this._config.html) return e2.innerHTML = "", void e2.append(t2);
            e2.textContent = t2.textContent;
          }
        }
        const Zn = /* @__PURE__ */ new Set(["sanitize", "allowList", "sanitizeFn"]), ts = "fade", es = "show", is = ".modal", ns = "hide.bs.modal", ss = "hover", os = "focus", rs = { AUTO: "auto", TOP: "top", RIGHT: p2() ? "left" : "right", BOTTOM: "bottom", LEFT: p2() ? "right" : "left" }, as = { allowList: Vn, animation: true, boundary: "clippingParents", container: false, customClass: "", delay: 0, fallbackPlacements: ["top", "right", "bottom", "left"], html: false, offset: [0, 6], placement: "top", popperConfig: null, sanitize: true, sanitizeFn: null, selector: false, template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>', title: "", trigger: "hover focus" }, ls = { allowList: "object", animation: "boolean", boundary: "(string|element)", container: "(string|element|boolean)", customClass: "(string|function)", delay: "(number|object)", fallbackPlacements: "array", html: "boolean", offset: "(array|string|function)", placement: "(string|function)", popperConfig: "(null|object|function)", sanitize: "boolean", sanitizeFn: "(null|function)", selector: "(string|boolean)", template: "string", title: "(string|element|function)", trigger: "string" };
        class cs extends W {
          constructor(t2, e2) {
            if (void 0 === vi) throw new TypeError("Bootstrap's tooltips require Popper (https://popper.js.org)");
            super(t2, e2), this._isEnabled = true, this._timeout = 0, this._isHovered = null, this._activeTrigger = {}, this._popper = null, this._templateFactory = null, this._newContent = null, this.tip = null, this._setListeners(), this._config.selector || this._fixTitle();
          }
          static get Default() {
            return as;
          }
          static get DefaultType() {
            return ls;
          }
          static get NAME() {
            return "tooltip";
          }
          enable() {
            this._isEnabled = true;
          }
          disable() {
            this._isEnabled = false;
          }
          toggleEnabled() {
            this._isEnabled = !this._isEnabled;
          }
          toggle() {
            this._isEnabled && (this._activeTrigger.click = !this._activeTrigger.click, this._isShown() ? this._leave() : this._enter());
          }
          dispose() {
            clearTimeout(this._timeout), N.off(this._element.closest(is), ns, this._hideModalHandler), this._element.getAttribute("data-bs-original-title") && this._element.setAttribute("title", this._element.getAttribute("data-bs-original-title")), this._disposePopper(), super.dispose();
          }
          show() {
            if ("none" === this._element.style.display) throw new Error("Please use show on visible elements");
            if (!this._isWithContent() || !this._isEnabled) return;
            const t2 = N.trigger(this._element, this.constructor.eventName("show")), e2 = (c2(this._element) || this._element.ownerDocument.documentElement).contains(this._element);
            if (t2.defaultPrevented || !e2) return;
            this._disposePopper();
            const i2 = this._getTipElement();
            this._element.setAttribute("aria-describedby", i2.getAttribute("id"));
            const { container: n2 } = this._config;
            if (this._element.ownerDocument.documentElement.contains(this.tip) || (n2.append(i2), N.trigger(this._element, this.constructor.eventName("inserted"))), this._popper = this._createPopper(i2), i2.classList.add(es), "ontouchstart" in document.documentElement) for (const t3 of [].concat(...document.body.children)) N.on(t3, "mouseover", h);
            this._queueCallback(() => {
              N.trigger(this._element, this.constructor.eventName("shown")), false === this._isHovered && this._leave(), this._isHovered = false;
            }, this.tip, this._isAnimated());
          }
          hide() {
            if (this._isShown() && !N.trigger(this._element, this.constructor.eventName("hide")).defaultPrevented) {
              if (this._getTipElement().classList.remove(es), "ontouchstart" in document.documentElement) for (const t2 of [].concat(...document.body.children)) N.off(t2, "mouseover", h);
              this._activeTrigger.click = false, this._activeTrigger[os] = false, this._activeTrigger[ss] = false, this._isHovered = null, this._queueCallback(() => {
                this._isWithActiveTrigger() || (this._isHovered || this._disposePopper(), this._element.removeAttribute("aria-describedby"), N.trigger(this._element, this.constructor.eventName("hidden")));
              }, this.tip, this._isAnimated());
            }
          }
          update() {
            this._popper && this._popper.update();
          }
          _isWithContent() {
            return Boolean(this._getTitle());
          }
          _getTipElement() {
            return this.tip || (this.tip = this._createTipElement(this._newContent || this._getContentForTemplate())), this.tip;
          }
          _createTipElement(t2) {
            const e2 = this._getTemplateFactory(t2).toHtml();
            if (!e2) return null;
            e2.classList.remove(ts, es), e2.classList.add(`bs-${this.constructor.NAME}-auto`);
            const i2 = ((t3) => {
              do {
                t3 += Math.floor(1e6 * Math.random());
              } while (document.getElementById(t3));
              return t3;
            })(this.constructor.NAME).toString();
            return e2.setAttribute("id", i2), this._isAnimated() && e2.classList.add(ts), e2;
          }
          setContent(t2) {
            this._newContent = t2, this._isShown() && (this._disposePopper(), this.show());
          }
          _getTemplateFactory(t2) {
            return this._templateFactory ? this._templateFactory.changeContent(t2) : this._templateFactory = new Jn({ ...this._config, content: t2, extraClass: this._resolvePossibleFunction(this._config.customClass) }), this._templateFactory;
          }
          _getContentForTemplate() {
            return { ".tooltip-inner": this._getTitle() };
          }
          _getTitle() {
            return this._resolvePossibleFunction(this._config.title) || this._element.getAttribute("data-bs-original-title");
          }
          _initializeOnDelegatedTarget(t2) {
            return this.constructor.getOrCreateInstance(t2.delegateTarget, this._getDelegateConfig());
          }
          _isAnimated() {
            return this._config.animation || this.tip && this.tip.classList.contains(ts);
          }
          _isShown() {
            return this.tip && this.tip.classList.contains(es);
          }
          _createPopper(t2) {
            const e2 = g(this._config.placement, [this, t2, this._element]), i2 = rs[e2.toUpperCase()];
            return bi(this._element, t2, this._getPopperConfig(i2));
          }
          _getOffset() {
            const { offset: t2 } = this._config;
            return "string" == typeof t2 ? t2.split(",").map((t3) => Number.parseInt(t3, 10)) : "function" == typeof t2 ? (e2) => t2(e2, this._element) : t2;
          }
          _resolvePossibleFunction(t2) {
            return g(t2, [this._element]);
          }
          _getPopperConfig(t2) {
            const e2 = { placement: t2, modifiers: [{ name: "flip", options: { fallbackPlacements: this._config.fallbackPlacements } }, { name: "offset", options: { offset: this._getOffset() } }, { name: "preventOverflow", options: { boundary: this._config.boundary } }, { name: "arrow", options: { element: `.${this.constructor.NAME}-arrow` } }, { name: "preSetPlacement", enabled: true, phase: "beforeMain", fn: (t3) => {
              this._getTipElement().setAttribute("data-popper-placement", t3.state.placement);
            } }] };
            return { ...e2, ...g(this._config.popperConfig, [e2]) };
          }
          _setListeners() {
            const t2 = this._config.trigger.split(" ");
            for (const e2 of t2) if ("click" === e2) N.on(this._element, this.constructor.eventName("click"), this._config.selector, (t3) => {
              this._initializeOnDelegatedTarget(t3).toggle();
            });
            else if ("manual" !== e2) {
              const t3 = e2 === ss ? this.constructor.eventName("mouseenter") : this.constructor.eventName("focusin"), i2 = e2 === ss ? this.constructor.eventName("mouseleave") : this.constructor.eventName("focusout");
              N.on(this._element, t3, this._config.selector, (t4) => {
                const e3 = this._initializeOnDelegatedTarget(t4);
                e3._activeTrigger["focusin" === t4.type ? os : ss] = true, e3._enter();
              }), N.on(this._element, i2, this._config.selector, (t4) => {
                const e3 = this._initializeOnDelegatedTarget(t4);
                e3._activeTrigger["focusout" === t4.type ? os : ss] = e3._element.contains(t4.relatedTarget), e3._leave();
              });
            }
            this._hideModalHandler = () => {
              this._element && this.hide();
            }, N.on(this._element.closest(is), ns, this._hideModalHandler);
          }
          _fixTitle() {
            const t2 = this._element.getAttribute("title");
            t2 && (this._element.getAttribute("aria-label") || this._element.textContent.trim() || this._element.setAttribute("aria-label", t2), this._element.setAttribute("data-bs-original-title", t2), this._element.removeAttribute("title"));
          }
          _enter() {
            this._isShown() || this._isHovered ? this._isHovered = true : (this._isHovered = true, this._setTimeout(() => {
              this._isHovered && this.show();
            }, this._config.delay.show));
          }
          _leave() {
            this._isWithActiveTrigger() || (this._isHovered = false, this._setTimeout(() => {
              this._isHovered || this.hide();
            }, this._config.delay.hide));
          }
          _setTimeout(t2, e2) {
            clearTimeout(this._timeout), this._timeout = setTimeout(t2, e2);
          }
          _isWithActiveTrigger() {
            return Object.values(this._activeTrigger).includes(true);
          }
          _getConfig(t2) {
            const e2 = F.getDataAttributes(this._element);
            for (const t3 of Object.keys(e2)) Zn.has(t3) && delete e2[t3];
            return t2 = { ...e2, ..."object" == typeof t2 && t2 ? t2 : {} }, t2 = this._mergeConfigObj(t2), t2 = this._configAfterMerge(t2), this._typeCheckConfig(t2), t2;
          }
          _configAfterMerge(t2) {
            return t2.container = false === t2.container ? document.body : r(t2.container), "number" == typeof t2.delay && (t2.delay = { show: t2.delay, hide: t2.delay }), "number" == typeof t2.title && (t2.title = t2.title.toString()), "number" == typeof t2.content && (t2.content = t2.content.toString()), t2;
          }
          _getDelegateConfig() {
            const t2 = {};
            for (const [e2, i2] of Object.entries(this._config)) this.constructor.Default[e2] !== i2 && (t2[e2] = i2);
            return t2.selector = false, t2.trigger = "manual", t2;
          }
          _disposePopper() {
            this._popper && (this._popper.destroy(), this._popper = null), this.tip && (this.tip.remove(), this.tip = null);
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = cs.getOrCreateInstance(this, t2);
              if ("string" == typeof t2) {
                if (void 0 === e2[t2]) throw new TypeError(`No method named "${t2}"`);
                e2[t2]();
              }
            });
          }
        }
        m(cs);
        const hs = { ...cs.Default, content: "", offset: [0, 8], placement: "right", template: '<div class="popover" role="tooltip"><div class="popover-arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>', trigger: "click" }, ds = { ...cs.DefaultType, content: "(null|string|element|function)" };
        class us extends cs {
          static get Default() {
            return hs;
          }
          static get DefaultType() {
            return ds;
          }
          static get NAME() {
            return "popover";
          }
          _isWithContent() {
            return this._getTitle() || this._getContent();
          }
          _getContentForTemplate() {
            return { ".popover-header": this._getTitle(), ".popover-body": this._getContent() };
          }
          _getContent() {
            return this._resolvePossibleFunction(this._config.content);
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = us.getOrCreateInstance(this, t2);
              if ("string" == typeof t2) {
                if (void 0 === e2[t2]) throw new TypeError(`No method named "${t2}"`);
                e2[t2]();
              }
            });
          }
        }
        m(us);
        const fs = ".bs.scrollspy", ps = `activate${fs}`, ms = `click${fs}`, gs = `load${fs}.data-api`, _s = "active", bs = "[href]", vs = ".nav-link", ys = `${vs}, .nav-item > ${vs}, .list-group-item`, ws = { offset: null, rootMargin: "0px 0px -25%", smoothScroll: false, target: null, threshold: [0.1, 0.5, 1] }, As = { offset: "(number|null)", rootMargin: "string", smoothScroll: "boolean", target: "element", threshold: "array" };
        class Es extends W {
          constructor(t2, e2) {
            super(t2, e2), this._targetLinks = /* @__PURE__ */ new Map(), this._observableSections = /* @__PURE__ */ new Map(), this._rootElement = "visible" === getComputedStyle(this._element).overflowY ? null : this._element, this._activeTarget = null, this._observer = null, this._previousScrollData = { visibleEntryTop: 0, parentScrollTop: 0 }, this.refresh();
          }
          static get Default() {
            return ws;
          }
          static get DefaultType() {
            return As;
          }
          static get NAME() {
            return "scrollspy";
          }
          refresh() {
            this._initializeTargetsAndObservables(), this._maybeEnableSmoothScroll(), this._observer ? this._observer.disconnect() : this._observer = this._getNewObserver();
            for (const t2 of this._observableSections.values()) this._observer.observe(t2);
          }
          dispose() {
            this._observer.disconnect(), super.dispose();
          }
          _configAfterMerge(t2) {
            return t2.target = r(t2.target) || document.body, t2.rootMargin = t2.offset ? `${t2.offset}px 0px -30%` : t2.rootMargin, "string" == typeof t2.threshold && (t2.threshold = t2.threshold.split(",").map((t3) => Number.parseFloat(t3))), t2;
          }
          _maybeEnableSmoothScroll() {
            this._config.smoothScroll && (N.off(this._config.target, ms), N.on(this._config.target, ms, bs, (t2) => {
              const e2 = this._observableSections.get(t2.target.hash);
              if (e2) {
                t2.preventDefault();
                const i2 = this._rootElement || window, n2 = e2.offsetTop - this._element.offsetTop;
                if (i2.scrollTo) return void i2.scrollTo({ top: n2, behavior: "smooth" });
                i2.scrollTop = n2;
              }
            }));
          }
          _getNewObserver() {
            const t2 = { root: this._rootElement, threshold: this._config.threshold, rootMargin: this._config.rootMargin };
            return new IntersectionObserver((t3) => this._observerCallback(t3), t2);
          }
          _observerCallback(t2) {
            const e2 = (t3) => this._targetLinks.get(`#${t3.target.id}`), i2 = (t3) => {
              this._previousScrollData.visibleEntryTop = t3.target.offsetTop, this._process(e2(t3));
            }, n2 = (this._rootElement || document.documentElement).scrollTop, s2 = n2 >= this._previousScrollData.parentScrollTop;
            this._previousScrollData.parentScrollTop = n2;
            for (const o2 of t2) {
              if (!o2.isIntersecting) {
                this._activeTarget = null, this._clearActiveClass(e2(o2));
                continue;
              }
              const t3 = o2.target.offsetTop >= this._previousScrollData.visibleEntryTop;
              if (s2 && t3) {
                if (i2(o2), !n2) return;
              } else s2 || t3 || i2(o2);
            }
          }
          _initializeTargetsAndObservables() {
            this._targetLinks = /* @__PURE__ */ new Map(), this._observableSections = /* @__PURE__ */ new Map();
            const t2 = z.find(bs, this._config.target);
            for (const e2 of t2) {
              if (!e2.hash || l(e2)) continue;
              const t3 = z.findOne(decodeURI(e2.hash), this._element);
              a(t3) && (this._targetLinks.set(decodeURI(e2.hash), e2), this._observableSections.set(e2.hash, t3));
            }
          }
          _process(t2) {
            this._activeTarget !== t2 && (this._clearActiveClass(this._config.target), this._activeTarget = t2, t2.classList.add(_s), this._activateParents(t2), N.trigger(this._element, ps, { relatedTarget: t2 }));
          }
          _activateParents(t2) {
            if (t2.classList.contains("dropdown-item")) z.findOne(".dropdown-toggle", t2.closest(".dropdown")).classList.add(_s);
            else for (const e2 of z.parents(t2, ".nav, .list-group")) for (const t3 of z.prev(e2, ys)) t3.classList.add(_s);
          }
          _clearActiveClass(t2) {
            t2.classList.remove(_s);
            const e2 = z.find(`${bs}.${_s}`, t2);
            for (const t3 of e2) t3.classList.remove(_s);
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = Es.getOrCreateInstance(this, t2);
              if ("string" == typeof t2) {
                if (void 0 === e2[t2] || t2.startsWith("_") || "constructor" === t2) throw new TypeError(`No method named "${t2}"`);
                e2[t2]();
              }
            });
          }
        }
        N.on(window, gs, () => {
          for (const t2 of z.find('[data-bs-spy="scroll"]')) Es.getOrCreateInstance(t2);
        }), m(Es);
        const Ts = ".bs.tab", Cs = `hide${Ts}`, Os = `hidden${Ts}`, xs = `show${Ts}`, ks = `shown${Ts}`, Ls = `click${Ts}`, Ss = `keydown${Ts}`, Ds = `load${Ts}`, $s = "ArrowLeft", Is = "ArrowRight", Ns = "ArrowUp", Ps = "ArrowDown", Ms = "Home", js = "End", Fs = "active", Hs = "fade", Ws = "show", Bs = ".dropdown-toggle", zs = `:not(${Bs})`, Rs = '[data-bs-toggle="tab"], [data-bs-toggle="pill"], [data-bs-toggle="list"]', qs = `.nav-link${zs}, .list-group-item${zs}, [role="tab"]${zs}, ${Rs}`, Vs = `.${Fs}[data-bs-toggle="tab"], .${Fs}[data-bs-toggle="pill"], .${Fs}[data-bs-toggle="list"]`;
        class Ks extends W {
          constructor(t2) {
            super(t2), this._parent = this._element.closest('.list-group, .nav, [role="tablist"]'), this._parent && (this._setInitialAttributes(this._parent, this._getChildren()), N.on(this._element, Ss, (t3) => this._keydown(t3)));
          }
          static get NAME() {
            return "tab";
          }
          show() {
            const t2 = this._element;
            if (this._elemIsActive(t2)) return;
            const e2 = this._getActiveElem(), i2 = e2 ? N.trigger(e2, Cs, { relatedTarget: t2 }) : null;
            N.trigger(t2, xs, { relatedTarget: e2 }).defaultPrevented || i2 && i2.defaultPrevented || (this._deactivate(e2, t2), this._activate(t2, e2));
          }
          _activate(t2, e2) {
            t2 && (t2.classList.add(Fs), this._activate(z.getElementFromSelector(t2)), this._queueCallback(() => {
              "tab" === t2.getAttribute("role") ? (t2.removeAttribute("tabindex"), t2.setAttribute("aria-selected", true), this._toggleDropDown(t2, true), N.trigger(t2, ks, { relatedTarget: e2 })) : t2.classList.add(Ws);
            }, t2, t2.classList.contains(Hs)));
          }
          _deactivate(t2, e2) {
            t2 && (t2.classList.remove(Fs), t2.blur(), this._deactivate(z.getElementFromSelector(t2)), this._queueCallback(() => {
              "tab" === t2.getAttribute("role") ? (t2.setAttribute("aria-selected", false), t2.setAttribute("tabindex", "-1"), this._toggleDropDown(t2, false), N.trigger(t2, Os, { relatedTarget: e2 })) : t2.classList.remove(Ws);
            }, t2, t2.classList.contains(Hs)));
          }
          _keydown(t2) {
            if (![$s, Is, Ns, Ps, Ms, js].includes(t2.key)) return;
            t2.stopPropagation(), t2.preventDefault();
            const e2 = this._getChildren().filter((t3) => !l(t3));
            let i2;
            if ([Ms, js].includes(t2.key)) i2 = e2[t2.key === Ms ? 0 : e2.length - 1];
            else {
              const n2 = [Is, Ps].includes(t2.key);
              i2 = b(e2, t2.target, n2, true);
            }
            i2 && (i2.focus({ preventScroll: true }), Ks.getOrCreateInstance(i2).show());
          }
          _getChildren() {
            return z.find(qs, this._parent);
          }
          _getActiveElem() {
            return this._getChildren().find((t2) => this._elemIsActive(t2)) || null;
          }
          _setInitialAttributes(t2, e2) {
            this._setAttributeIfNotExists(t2, "role", "tablist");
            for (const t3 of e2) this._setInitialAttributesOnChild(t3);
          }
          _setInitialAttributesOnChild(t2) {
            t2 = this._getInnerElement(t2);
            const e2 = this._elemIsActive(t2), i2 = this._getOuterElement(t2);
            t2.setAttribute("aria-selected", e2), i2 !== t2 && this._setAttributeIfNotExists(i2, "role", "presentation"), e2 || t2.setAttribute("tabindex", "-1"), this._setAttributeIfNotExists(t2, "role", "tab"), this._setInitialAttributesOnTargetPanel(t2);
          }
          _setInitialAttributesOnTargetPanel(t2) {
            const e2 = z.getElementFromSelector(t2);
            e2 && (this._setAttributeIfNotExists(e2, "role", "tabpanel"), t2.id && this._setAttributeIfNotExists(e2, "aria-labelledby", `${t2.id}`));
          }
          _toggleDropDown(t2, e2) {
            const i2 = this._getOuterElement(t2);
            if (!i2.classList.contains("dropdown")) return;
            const n2 = (t3, n3) => {
              const s2 = z.findOne(t3, i2);
              s2 && s2.classList.toggle(n3, e2);
            };
            n2(Bs, Fs), n2(".dropdown-menu", Ws), i2.setAttribute("aria-expanded", e2);
          }
          _setAttributeIfNotExists(t2, e2, i2) {
            t2.hasAttribute(e2) || t2.setAttribute(e2, i2);
          }
          _elemIsActive(t2) {
            return t2.classList.contains(Fs);
          }
          _getInnerElement(t2) {
            return t2.matches(qs) ? t2 : z.findOne(qs, t2);
          }
          _getOuterElement(t2) {
            return t2.closest(".nav-item, .list-group-item") || t2;
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = Ks.getOrCreateInstance(this);
              if ("string" == typeof t2) {
                if (void 0 === e2[t2] || t2.startsWith("_") || "constructor" === t2) throw new TypeError(`No method named "${t2}"`);
                e2[t2]();
              }
            });
          }
        }
        N.on(document, Ls, Rs, function(t2) {
          ["A", "AREA"].includes(this.tagName) && t2.preventDefault(), l(this) || Ks.getOrCreateInstance(this).show();
        }), N.on(window, Ds, () => {
          for (const t2 of z.find(Vs)) Ks.getOrCreateInstance(t2);
        }), m(Ks);
        const Qs = ".bs.toast", Xs = `mouseover${Qs}`, Ys = `mouseout${Qs}`, Us = `focusin${Qs}`, Gs = `focusout${Qs}`, Js = `hide${Qs}`, Zs = `hidden${Qs}`, to = `show${Qs}`, eo = `shown${Qs}`, io = "hide", no = "show", so = "showing", oo = { animation: "boolean", autohide: "boolean", delay: "number" }, ro = { animation: true, autohide: true, delay: 5e3 };
        class ao extends W {
          constructor(t2, e2) {
            super(t2, e2), this._timeout = null, this._hasMouseInteraction = false, this._hasKeyboardInteraction = false, this._setListeners();
          }
          static get Default() {
            return ro;
          }
          static get DefaultType() {
            return oo;
          }
          static get NAME() {
            return "toast";
          }
          show() {
            N.trigger(this._element, to).defaultPrevented || (this._clearTimeout(), this._config.animation && this._element.classList.add("fade"), this._element.classList.remove(io), d(this._element), this._element.classList.add(no, so), this._queueCallback(() => {
              this._element.classList.remove(so), N.trigger(this._element, eo), this._maybeScheduleHide();
            }, this._element, this._config.animation));
          }
          hide() {
            this.isShown() && (N.trigger(this._element, Js).defaultPrevented || (this._element.classList.add(so), this._queueCallback(() => {
              this._element.classList.add(io), this._element.classList.remove(so, no), N.trigger(this._element, Zs);
            }, this._element, this._config.animation)));
          }
          dispose() {
            this._clearTimeout(), this.isShown() && this._element.classList.remove(no), super.dispose();
          }
          isShown() {
            return this._element.classList.contains(no);
          }
          _maybeScheduleHide() {
            this._config.autohide && (this._hasMouseInteraction || this._hasKeyboardInteraction || (this._timeout = setTimeout(() => {
              this.hide();
            }, this._config.delay)));
          }
          _onInteraction(t2, e2) {
            switch (t2.type) {
              case "mouseover":
              case "mouseout":
                this._hasMouseInteraction = e2;
                break;
              case "focusin":
              case "focusout":
                this._hasKeyboardInteraction = e2;
            }
            if (e2) return void this._clearTimeout();
            const i2 = t2.relatedTarget;
            this._element === i2 || this._element.contains(i2) || this._maybeScheduleHide();
          }
          _setListeners() {
            N.on(this._element, Xs, (t2) => this._onInteraction(t2, true)), N.on(this._element, Ys, (t2) => this._onInteraction(t2, false)), N.on(this._element, Us, (t2) => this._onInteraction(t2, true)), N.on(this._element, Gs, (t2) => this._onInteraction(t2, false));
          }
          _clearTimeout() {
            clearTimeout(this._timeout), this._timeout = null;
          }
          static jQueryInterface(t2) {
            return this.each(function() {
              const e2 = ao.getOrCreateInstance(this, t2);
              if ("string" == typeof t2) {
                if (void 0 === e2[t2]) throw new TypeError(`No method named "${t2}"`);
                e2[t2](this);
              }
            });
          }
        }
        return R(ao), m(ao), { Alert: Q, Button: Y, Carousel: xt, Collapse: Bt, Dropdown: qi, Modal: On, Offcanvas: qn, Popover: us, ScrollSpy: Es, Tab: Ks, Toast: ao, Tooltip: cs };
      });
    }
  });

  // assets/js/phoenix.js
  var require_phoenix = __commonJS({
    "assets/js/phoenix.js"(exports, module) {
      !function(e, t) {
        "object" == typeof exports && "object" == typeof module ? module.exports = t() : "function" == typeof define && define.amd ? define([], t) : "object" == typeof exports ? exports.Phoenix = t() : e.Phoenix = t();
      }(exports, function() {
        return function(e) {
          var t = {};
          function n(i) {
            if (t[i]) return t[i].exports;
            var o = t[i] = { i, l: false, exports: {} };
            return e[i].call(o.exports, o, o.exports, n), o.l = true, o.exports;
          }
          return n.m = e, n.c = t, n.d = function(e2, t2, i) {
            n.o(e2, t2) || Object.defineProperty(e2, t2, { enumerable: true, get: i });
          }, n.r = function(e2) {
            "undefined" != typeof Symbol && Symbol.toStringTag && Object.defineProperty(e2, Symbol.toStringTag, { value: "Module" }), Object.defineProperty(e2, "__esModule", { value: true });
          }, n.t = function(e2, t2) {
            if (1 & t2 && (e2 = n(e2)), 8 & t2) return e2;
            if (4 & t2 && "object" == typeof e2 && e2 && e2.__esModule) return e2;
            var i = /* @__PURE__ */ Object.create(null);
            if (n.r(i), Object.defineProperty(i, "default", { enumerable: true, value: e2 }), 2 & t2 && "string" != typeof e2) for (var o in e2) n.d(i, o, function(t3) {
              return e2[t3];
            }.bind(null, o));
            return i;
          }, n.n = function(e2) {
            var t2 = e2 && e2.__esModule ? function() {
              return e2.default;
            } : function() {
              return e2;
            };
            return n.d(t2, "a", t2), t2;
          }, n.o = function(e2, t2) {
            return Object.prototype.hasOwnProperty.call(e2, t2);
          }, n.p = "", n(n.s = 0);
        }([function(e, t, n) {
          (function(t2) {
            e.exports = t2.Phoenix = n(2);
          }).call(this, n(1));
        }, function(e, t) {
          var n;
          n = /* @__PURE__ */ function() {
            return this;
          }();
          try {
            n = n || new Function("return this")();
          } catch (e2) {
            "object" == typeof window && (n = window);
          }
          e.exports = n;
        }, function(e, t, n) {
          "use strict";
          function i(e2) {
            return function(e3) {
              if (Array.isArray(e3)) return a(e3);
            }(e2) || function(e3) {
              if ("undefined" != typeof Symbol && Symbol.iterator in Object(e3)) return Array.from(e3);
            }(e2) || s(e2) || function() {
              throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
            }();
          }
          function o(e2) {
            return (o = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function(e3) {
              return typeof e3;
            } : function(e3) {
              return e3 && "function" == typeof Symbol && e3.constructor === Symbol && e3 !== Symbol.prototype ? "symbol" : typeof e3;
            })(e2);
          }
          function r(e2, t2) {
            return function(e3) {
              if (Array.isArray(e3)) return e3;
            }(e2) || function(e3, t3) {
              if ("undefined" == typeof Symbol || !(Symbol.iterator in Object(e3))) return;
              var n2 = [], i2 = true, o2 = false, r2 = void 0;
              try {
                for (var s2, a2 = e3[Symbol.iterator](); !(i2 = (s2 = a2.next()).done) && (n2.push(s2.value), !t3 || n2.length !== t3); i2 = true) ;
              } catch (e4) {
                o2 = true, r2 = e4;
              } finally {
                try {
                  i2 || null == a2.return || a2.return();
                } finally {
                  if (o2) throw r2;
                }
              }
              return n2;
            }(e2, t2) || s(e2, t2) || function() {
              throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.");
            }();
          }
          function s(e2, t2) {
            if (e2) {
              if ("string" == typeof e2) return a(e2, t2);
              var n2 = Object.prototype.toString.call(e2).slice(8, -1);
              return "Object" === n2 && e2.constructor && (n2 = e2.constructor.name), "Map" === n2 || "Set" === n2 ? Array.from(n2) : "Arguments" === n2 || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n2) ? a(e2, t2) : void 0;
            }
          }
          function a(e2, t2) {
            (null == t2 || t2 > e2.length) && (t2 = e2.length);
            for (var n2 = 0, i2 = new Array(t2); n2 < t2; n2++) i2[n2] = e2[n2];
            return i2;
          }
          function c2(e2, t2) {
            if (!(e2 instanceof t2)) throw new TypeError("Cannot call a class as a function");
          }
          function u(e2, t2) {
            for (var n2 = 0; n2 < t2.length; n2++) {
              var i2 = t2[n2];
              i2.enumerable = i2.enumerable || false, i2.configurable = true, "value" in i2 && (i2.writable = true), Object.defineProperty(e2, i2.key, i2);
            }
          }
          function h(e2, t2, n2) {
            return t2 && u(e2.prototype, t2), n2 && u(e2, n2), e2;
          }
          n.r(t), n.d(t, "Channel", function() {
            return O;
          }), n.d(t, "Serializer", function() {
            return _;
          }), n.d(t, "Socket", function() {
            return H;
          }), n.d(t, "LongPoll", function() {
            return U;
          }), n.d(t, "Ajax", function() {
            return D;
          }), n.d(t, "Presence", function() {
            return M;
          });
          var l = "undefined" != typeof self ? self : null, f = "undefined" != typeof window ? window : null, d = l || f || void 0, p2 = 0, v = 1, y = 2, m = 3, g = "closed", k = "errored", b = "joined", j = "joining", T = "leaving", C = "phx_close", R = "phx_error", E = "phx_join", w = "phx_reply", S = "phx_leave", A = "longpoll", L = "websocket", x = function(e2) {
            if ("function" == typeof e2) return e2;
            return function() {
              return e2;
            };
          }, P = function() {
            function e2(t2, n2, i2, o2) {
              c2(this, e2), this.channel = t2, this.event = n2, this.payload = i2 || function() {
                return {};
              }, this.receivedResp = null, this.timeout = o2, this.timeoutTimer = null, this.recHooks = [], this.sent = false;
            }
            return h(e2, [{ key: "resend", value: function(e3) {
              this.timeout = e3, this.reset(), this.send();
            } }, { key: "send", value: function() {
              this.hasReceived("timeout") || (this.startTimeout(), this.sent = true, this.channel.socket.push({ topic: this.channel.topic, event: this.event, payload: this.payload(), ref: this.ref, join_ref: this.channel.joinRef() }));
            } }, { key: "receive", value: function(e3, t2) {
              return this.hasReceived(e3) && t2(this.receivedResp.response), this.recHooks.push({ status: e3, callback: t2 }), this;
            } }, { key: "reset", value: function() {
              this.cancelRefEvent(), this.ref = null, this.refEvent = null, this.receivedResp = null, this.sent = false;
            } }, { key: "matchReceive", value: function(e3) {
              var t2 = e3.status, n2 = e3.response;
              e3.ref;
              this.recHooks.filter(function(e4) {
                return e4.status === t2;
              }).forEach(function(e4) {
                return e4.callback(n2);
              });
            } }, { key: "cancelRefEvent", value: function() {
              this.refEvent && this.channel.off(this.refEvent);
            } }, { key: "cancelTimeout", value: function() {
              clearTimeout(this.timeoutTimer), this.timeoutTimer = null;
            } }, { key: "startTimeout", value: function() {
              var e3 = this;
              this.timeoutTimer && this.cancelTimeout(), this.ref = this.channel.socket.makeRef(), this.refEvent = this.channel.replyEventName(this.ref), this.channel.on(this.refEvent, function(t2) {
                e3.cancelRefEvent(), e3.cancelTimeout(), e3.receivedResp = t2, e3.matchReceive(t2);
              }), this.timeoutTimer = setTimeout(function() {
                e3.trigger("timeout", {});
              }, this.timeout);
            } }, { key: "hasReceived", value: function(e3) {
              return this.receivedResp && this.receivedResp.status === e3;
            } }, { key: "trigger", value: function(e3, t2) {
              this.channel.trigger(this.refEvent, { status: e3, response: t2 });
            } }]), e2;
          }(), O = function() {
            function e2(t2, n2, i2) {
              var o2 = this;
              c2(this, e2), this.state = g, this.topic = t2, this.params = x(n2 || {}), this.socket = i2, this.bindings = [], this.bindingRef = 0, this.timeout = this.socket.timeout, this.joinedOnce = false, this.joinPush = new P(this, E, this.params, this.timeout), this.pushBuffer = [], this.stateChangeRefs = [], this.rejoinTimer = new N(function() {
                o2.socket.isConnected() && o2.rejoin();
              }, this.socket.rejoinAfterMs), this.stateChangeRefs.push(this.socket.onError(function() {
                return o2.rejoinTimer.reset();
              })), this.stateChangeRefs.push(this.socket.onOpen(function() {
                o2.rejoinTimer.reset(), o2.isErrored() && o2.rejoin();
              })), this.joinPush.receive("ok", function() {
                o2.state = b, o2.rejoinTimer.reset(), o2.pushBuffer.forEach(function(e3) {
                  return e3.send();
                }), o2.pushBuffer = [];
              }), this.joinPush.receive("error", function() {
                o2.state = k, o2.socket.isConnected() && o2.rejoinTimer.scheduleTimeout();
              }), this.onClose(function() {
                o2.rejoinTimer.reset(), o2.socket.hasLogger() && o2.socket.log("channel", "close ".concat(o2.topic, " ").concat(o2.joinRef())), o2.state = g, o2.socket.remove(o2);
              }), this.onError(function(e3) {
                o2.socket.hasLogger() && o2.socket.log("channel", "error ".concat(o2.topic), e3), o2.isJoining() && o2.joinPush.reset(), o2.state = k, o2.socket.isConnected() && o2.rejoinTimer.scheduleTimeout();
              }), this.joinPush.receive("timeout", function() {
                o2.socket.hasLogger() && o2.socket.log("channel", "timeout ".concat(o2.topic, " (").concat(o2.joinRef(), ")"), o2.joinPush.timeout), new P(o2, S, x({}), o2.timeout).send(), o2.state = k, o2.joinPush.reset(), o2.socket.isConnected() && o2.rejoinTimer.scheduleTimeout();
              }), this.on(w, function(e3, t3) {
                o2.trigger(o2.replyEventName(t3), e3);
              });
            }
            return h(e2, [{ key: "join", value: function() {
              var e3 = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : this.timeout;
              if (this.joinedOnce) throw new Error("tried to join multiple times. 'join' can only be called a single time per channel instance");
              return this.timeout = e3, this.joinedOnce = true, this.rejoin(), this.joinPush;
            } }, { key: "onClose", value: function(e3) {
              this.on(C, e3);
            } }, { key: "onError", value: function(e3) {
              return this.on(R, function(t2) {
                return e3(t2);
              });
            } }, { key: "on", value: function(e3, t2) {
              var n2 = this.bindingRef++;
              return this.bindings.push({ event: e3, ref: n2, callback: t2 }), n2;
            } }, { key: "off", value: function(e3, t2) {
              this.bindings = this.bindings.filter(function(n2) {
                return !(n2.event === e3 && (void 0 === t2 || t2 === n2.ref));
              });
            } }, { key: "canPush", value: function() {
              return this.socket.isConnected() && this.isJoined();
            } }, { key: "push", value: function(e3, t2) {
              var n2 = arguments.length > 2 && void 0 !== arguments[2] ? arguments[2] : this.timeout;
              if (t2 = t2 || {}, !this.joinedOnce) throw new Error("tried to push '".concat(e3, "' to '").concat(this.topic, "' before joining. Use channel.join() before pushing events"));
              var i2 = new P(this, e3, function() {
                return t2;
              }, n2);
              return this.canPush() ? i2.send() : (i2.startTimeout(), this.pushBuffer.push(i2)), i2;
            } }, { key: "leave", value: function() {
              var e3 = this, t2 = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : this.timeout;
              this.rejoinTimer.reset(), this.joinPush.cancelTimeout(), this.state = T;
              var n2 = function() {
                e3.socket.hasLogger() && e3.socket.log("channel", "leave ".concat(e3.topic)), e3.trigger(C, "leave");
              }, i2 = new P(this, S, x({}), t2);
              return i2.receive("ok", function() {
                return n2();
              }).receive("timeout", function() {
                return n2();
              }), i2.send(), this.canPush() || i2.trigger("ok", {}), i2;
            } }, { key: "onMessage", value: function(e3, t2, n2) {
              return t2;
            } }, { key: "isMember", value: function(e3, t2, n2, i2) {
              return this.topic === e3 && (!i2 || i2 === this.joinRef() || (this.socket.hasLogger() && this.socket.log("channel", "dropping outdated message", { topic: e3, event: t2, payload: n2, joinRef: i2 }), false));
            } }, { key: "joinRef", value: function() {
              return this.joinPush.ref;
            } }, { key: "rejoin", value: function() {
              var e3 = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : this.timeout;
              this.isLeaving() || (this.socket.leaveOpenTopic(this.topic), this.state = j, this.joinPush.resend(e3));
            } }, { key: "trigger", value: function(e3, t2, n2, i2) {
              var o2 = this.onMessage(e3, t2, n2, i2);
              if (t2 && !o2) throw new Error("channel onMessage callbacks must return the payload, modified or unmodified");
              for (var r2 = this.bindings.filter(function(t3) {
                return t3.event === e3;
              }), s2 = 0; s2 < r2.length; s2++) {
                r2[s2].callback(o2, n2, i2 || this.joinRef());
              }
            } }, { key: "replyEventName", value: function(e3) {
              return "chan_reply_".concat(e3);
            } }, { key: "isClosed", value: function() {
              return this.state === g;
            } }, { key: "isErrored", value: function() {
              return this.state === k;
            } }, { key: "isJoined", value: function() {
              return this.state === b;
            } }, { key: "isJoining", value: function() {
              return this.state === j;
            } }, { key: "isLeaving", value: function() {
              return this.state === T;
            } }]), e2;
          }(), _ = { HEADER_LENGTH: 1, META_LENGTH: 4, KINDS: { push: 0, reply: 1, broadcast: 2 }, encode: function(e2, t2) {
            if (e2.payload.constructor === ArrayBuffer) return t2(this.binaryEncode(e2));
            var n2 = [e2.join_ref, e2.ref, e2.topic, e2.event, e2.payload];
            return t2(JSON.stringify(n2));
          }, decode: function(e2, t2) {
            if (e2.constructor === ArrayBuffer) return t2(this.binaryDecode(e2));
            var n2 = r(JSON.parse(e2), 5);
            return t2({ join_ref: n2[0], ref: n2[1], topic: n2[2], event: n2[3], payload: n2[4] });
          }, binaryEncode: function(e2) {
            var t2 = e2.join_ref, n2 = e2.ref, i2 = e2.event, o2 = e2.topic, r2 = e2.payload, s2 = this.META_LENGTH + t2.length + n2.length + o2.length + i2.length, a2 = new ArrayBuffer(this.HEADER_LENGTH + s2), c3 = new DataView(a2), u2 = 0;
            c3.setUint8(u2++, this.KINDS.push), c3.setUint8(u2++, t2.length), c3.setUint8(u2++, n2.length), c3.setUint8(u2++, o2.length), c3.setUint8(u2++, i2.length), Array.from(t2, function(e3) {
              return c3.setUint8(u2++, e3.charCodeAt(0));
            }), Array.from(n2, function(e3) {
              return c3.setUint8(u2++, e3.charCodeAt(0));
            }), Array.from(o2, function(e3) {
              return c3.setUint8(u2++, e3.charCodeAt(0));
            }), Array.from(i2, function(e3) {
              return c3.setUint8(u2++, e3.charCodeAt(0));
            });
            var h2 = new Uint8Array(a2.byteLength + r2.byteLength);
            return h2.set(new Uint8Array(a2), 0), h2.set(new Uint8Array(r2), a2.byteLength), h2.buffer;
          }, binaryDecode: function(e2) {
            var t2 = new DataView(e2), n2 = t2.getUint8(0), i2 = new TextDecoder();
            switch (n2) {
              case this.KINDS.push:
                return this.decodePush(e2, t2, i2);
              case this.KINDS.reply:
                return this.decodeReply(e2, t2, i2);
              case this.KINDS.broadcast:
                return this.decodeBroadcast(e2, t2, i2);
            }
          }, decodePush: function(e2, t2, n2) {
            var i2 = t2.getUint8(1), o2 = t2.getUint8(2), r2 = t2.getUint8(3), s2 = this.HEADER_LENGTH + this.META_LENGTH - 1, a2 = n2.decode(e2.slice(s2, s2 + i2));
            s2 += i2;
            var c3 = n2.decode(e2.slice(s2, s2 + o2));
            s2 += o2;
            var u2 = n2.decode(e2.slice(s2, s2 + r2));
            return s2 += r2, { join_ref: a2, ref: null, topic: c3, event: u2, payload: e2.slice(s2, e2.byteLength) };
          }, decodeReply: function(e2, t2, n2) {
            var i2 = t2.getUint8(1), o2 = t2.getUint8(2), r2 = t2.getUint8(3), s2 = t2.getUint8(4), a2 = this.HEADER_LENGTH + this.META_LENGTH, c3 = n2.decode(e2.slice(a2, a2 + i2));
            a2 += i2;
            var u2 = n2.decode(e2.slice(a2, a2 + o2));
            a2 += o2;
            var h2 = n2.decode(e2.slice(a2, a2 + r2));
            a2 += r2;
            var l2 = n2.decode(e2.slice(a2, a2 + s2));
            a2 += s2;
            var f2 = e2.slice(a2, e2.byteLength);
            return { join_ref: c3, ref: u2, topic: h2, event: w, payload: { status: l2, response: f2 } };
          }, decodeBroadcast: function(e2, t2, n2) {
            var i2 = t2.getUint8(1), o2 = t2.getUint8(2), r2 = this.HEADER_LENGTH + 2, s2 = n2.decode(e2.slice(r2, r2 + i2));
            r2 += i2;
            var a2 = n2.decode(e2.slice(r2, r2 + o2));
            return r2 += o2, { join_ref: null, ref: null, topic: s2, event: a2, payload: e2.slice(r2, e2.byteLength) };
          } }, H = function() {
            function e2(t2) {
              var n2 = this, i2 = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {};
              c2(this, e2), this.stateChangeCallbacks = { open: [], close: [], error: [], message: [] }, this.channels = [], this.sendBuffer = [], this.ref = 0, this.timeout = i2.timeout || 1e4, this.transport = i2.transport || d.WebSocket || U, this.defaultEncoder = _.encode.bind(_), this.defaultDecoder = _.decode.bind(_), this.closeWasClean = false, this.unloaded = false, this.binaryType = i2.binaryType || "arraybuffer", this.transport !== U ? (this.encode = i2.encode || this.defaultEncoder, this.decode = i2.decode || this.defaultDecoder) : (this.encode = this.defaultEncoder, this.decode = this.defaultDecoder), f && f.addEventListener && f.addEventListener("beforeunload", function(e3) {
                n2.conn && (n2.unloaded = true, n2.abnormalClose("unloaded"));
              }), this.heartbeatIntervalMs = i2.heartbeatIntervalMs || 3e4, this.rejoinAfterMs = function(e3) {
                return i2.rejoinAfterMs ? i2.rejoinAfterMs(e3) : [1e3, 2e3, 5e3][e3 - 1] || 1e4;
              }, this.reconnectAfterMs = function(e3) {
                return n2.unloaded ? 100 : i2.reconnectAfterMs ? i2.reconnectAfterMs(e3) : [10, 50, 100, 150, 200, 250, 500, 1e3, 2e3][e3 - 1] || 5e3;
              }, this.logger = i2.logger || null, this.longpollerTimeout = i2.longpollerTimeout || 2e4, this.params = x(i2.params || {}), this.endPoint = "".concat(t2, "/").concat(L), this.vsn = i2.vsn || "2.0.0", this.heartbeatTimer = null, this.pendingHeartbeatRef = null, this.reconnectTimer = new N(function() {
                n2.teardown(function() {
                  return n2.connect();
                });
              }, this.reconnectAfterMs);
            }
            return h(e2, [{ key: "protocol", value: function() {
              return location.protocol.match(/^https/) ? "wss" : "ws";
            } }, { key: "endPointURL", value: function() {
              var e3 = D.appendParams(D.appendParams(this.endPoint, this.params()), { vsn: this.vsn });
              return "/" !== e3.charAt(0) ? e3 : "/" === e3.charAt(1) ? "".concat(this.protocol(), ":").concat(e3) : "".concat(this.protocol(), "://").concat(location.host).concat(e3);
            } }, { key: "disconnect", value: function(e3, t2, n2) {
              this.closeWasClean = true, this.reconnectTimer.reset(), this.teardown(e3, t2, n2);
            } }, { key: "connect", value: function(e3) {
              var t2 = this;
              e3 && (console && console.log("passing params to connect is deprecated. Instead pass :params to the Socket constructor"), this.params = x(e3)), this.conn || (this.closeWasClean = false, this.conn = new this.transport(this.endPointURL()), this.conn.binaryType = this.binaryType, this.conn.timeout = this.longpollerTimeout, this.conn.onopen = function() {
                return t2.onConnOpen();
              }, this.conn.onerror = function(e4) {
                return t2.onConnError(e4);
              }, this.conn.onmessage = function(e4) {
                return t2.onConnMessage(e4);
              }, this.conn.onclose = function(e4) {
                return t2.onConnClose(e4);
              });
            } }, { key: "log", value: function(e3, t2, n2) {
              this.logger(e3, t2, n2);
            } }, { key: "hasLogger", value: function() {
              return null !== this.logger;
            } }, { key: "onOpen", value: function(e3) {
              var t2 = this.makeRef();
              return this.stateChangeCallbacks.open.push([t2, e3]), t2;
            } }, { key: "onClose", value: function(e3) {
              var t2 = this.makeRef();
              return this.stateChangeCallbacks.close.push([t2, e3]), t2;
            } }, { key: "onError", value: function(e3) {
              var t2 = this.makeRef();
              return this.stateChangeCallbacks.error.push([t2, e3]), t2;
            } }, { key: "onMessage", value: function(e3) {
              var t2 = this.makeRef();
              return this.stateChangeCallbacks.message.push([t2, e3]), t2;
            } }, { key: "onConnOpen", value: function() {
              this.hasLogger() && this.log("transport", "connected to ".concat(this.endPointURL())), this.unloaded = false, this.closeWasClean = false, this.flushSendBuffer(), this.reconnectTimer.reset(), this.resetHeartbeat(), this.stateChangeCallbacks.open.forEach(function(e3) {
                return (0, r(e3, 2)[1])();
              });
            } }, { key: "heartbeatTimeout", value: function() {
              this.pendingHeartbeatRef && (this.pendingHeartbeatRef = null, this.hasLogger() && this.log("transport", "heartbeat timeout. Attempting to re-establish connection"), this.abnormalClose("heartbeat timeout"));
            } }, { key: "resetHeartbeat", value: function() {
              var e3 = this;
              this.conn && this.conn.skipHeartbeat || (this.pendingHeartbeatRef = null, clearTimeout(this.heartbeatTimer), setTimeout(function() {
                return e3.sendHeartbeat();
              }, this.heartbeatIntervalMs));
            } }, { key: "teardown", value: function(e3, t2, n2) {
              var i2 = this;
              if (!this.conn) return e3 && e3();
              this.waitForBufferDone(function() {
                i2.conn && (t2 ? i2.conn.close(t2, n2 || "") : i2.conn.close()), i2.waitForSocketClosed(function() {
                  i2.conn && (i2.conn.onclose = function() {
                  }, i2.conn = null), e3 && e3();
                });
              });
            } }, { key: "waitForBufferDone", value: function(e3) {
              var t2 = this, n2 = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : 1;
              5 !== n2 && this.conn && this.conn.bufferedAmount ? setTimeout(function() {
                t2.waitForBufferDone(e3, n2 + 1);
              }, 150 * n2) : e3();
            } }, { key: "waitForSocketClosed", value: function(e3) {
              var t2 = this, n2 = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : 1;
              5 !== n2 && this.conn && this.conn.readyState !== m ? setTimeout(function() {
                t2.waitForSocketClosed(e3, n2 + 1);
              }, 150 * n2) : e3();
            } }, { key: "onConnClose", value: function(e3) {
              this.hasLogger() && this.log("transport", "close", e3), this.triggerChanError(), clearTimeout(this.heartbeatTimer), this.closeWasClean || this.reconnectTimer.scheduleTimeout(), this.stateChangeCallbacks.close.forEach(function(t2) {
                return (0, r(t2, 2)[1])(e3);
              });
            } }, { key: "onConnError", value: function(e3) {
              this.hasLogger() && this.log("transport", e3), this.triggerChanError(), this.stateChangeCallbacks.error.forEach(function(t2) {
                return (0, r(t2, 2)[1])(e3);
              });
            } }, { key: "triggerChanError", value: function() {
              this.channels.forEach(function(e3) {
                e3.isErrored() || e3.isLeaving() || e3.isClosed() || e3.trigger(R);
              });
            } }, { key: "connectionState", value: function() {
              switch (this.conn && this.conn.readyState) {
                case p2:
                  return "connecting";
                case v:
                  return "open";
                case y:
                  return "closing";
                default:
                  return "closed";
              }
            } }, { key: "isConnected", value: function() {
              return "open" === this.connectionState();
            } }, { key: "remove", value: function(e3) {
              this.off(e3.stateChangeRefs), this.channels = this.channels.filter(function(t2) {
                return t2.joinRef() !== e3.joinRef();
              });
            } }, { key: "off", value: function(e3) {
              for (var t2 in this.stateChangeCallbacks) this.stateChangeCallbacks[t2] = this.stateChangeCallbacks[t2].filter(function(t3) {
                var n2 = r(t3, 1)[0];
                return -1 === e3.indexOf(n2);
              });
            } }, { key: "channel", value: function(e3) {
              var t2 = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {}, n2 = new O(e3, t2, this);
              return this.channels.push(n2), n2;
            } }, { key: "push", value: function(e3) {
              var t2 = this;
              if (this.hasLogger()) {
                var n2 = e3.topic, i2 = e3.event, o2 = e3.payload, r2 = e3.ref, s2 = e3.join_ref;
                this.log("push", "".concat(n2, " ").concat(i2, " (").concat(s2, ", ").concat(r2, ")"), o2);
              }
              this.isConnected() ? this.encode(e3, function(e4) {
                return t2.conn.send(e4);
              }) : this.sendBuffer.push(function() {
                return t2.encode(e3, function(e4) {
                  return t2.conn.send(e4);
                });
              });
            } }, { key: "makeRef", value: function() {
              var e3 = this.ref + 1;
              return e3 === this.ref ? this.ref = 0 : this.ref = e3, this.ref.toString();
            } }, { key: "sendHeartbeat", value: function() {
              var e3 = this;
              this.pendingHeartbeatRef && !this.isConnected() || (this.pendingHeartbeatRef = this.makeRef(), this.push({ topic: "phoenix", event: "heartbeat", payload: {}, ref: this.pendingHeartbeatRef }), this.heartbeatTimer = setTimeout(function() {
                return e3.heartbeatTimeout();
              }, this.heartbeatIntervalMs));
            } }, { key: "abnormalClose", value: function(e3) {
              this.closeWasClean = false, this.isConnected() && this.conn.close(1e3, e3);
            } }, { key: "flushSendBuffer", value: function() {
              this.isConnected() && this.sendBuffer.length > 0 && (this.sendBuffer.forEach(function(e3) {
                return e3();
              }), this.sendBuffer = []);
            } }, { key: "onConnMessage", value: function(e3) {
              var t2 = this;
              this.decode(e3.data, function(e4) {
                var n2 = e4.topic, i2 = e4.event, o2 = e4.payload, s2 = e4.ref, a2 = e4.join_ref;
                s2 && s2 === t2.pendingHeartbeatRef && (clearTimeout(t2.heartbeatTimer), t2.pendingHeartbeatRef = null, setTimeout(function() {
                  return t2.sendHeartbeat();
                }, t2.heartbeatIntervalMs)), t2.hasLogger() && t2.log("receive", "".concat(o2.status || "", " ").concat(n2, " ").concat(i2, " ").concat(s2 && "(" + s2 + ")" || ""), o2);
                for (var c3 = 0; c3 < t2.channels.length; c3++) {
                  var u2 = t2.channels[c3];
                  u2.isMember(n2, i2, o2, a2) && u2.trigger(i2, o2, s2, a2);
                }
                for (var h2 = 0; h2 < t2.stateChangeCallbacks.message.length; h2++) {
                  (0, r(t2.stateChangeCallbacks.message[h2], 2)[1])(e4);
                }
              });
            } }, { key: "leaveOpenTopic", value: function(e3) {
              var t2 = this.channels.find(function(t3) {
                return t3.topic === e3 && (t3.isJoined() || t3.isJoining());
              });
              t2 && (this.hasLogger() && this.log("transport", 'leaving duplicate topic "'.concat(e3, '"')), t2.leave());
            } }]), e2;
          }(), U = function() {
            function e2(t2) {
              c2(this, e2), this.endPoint = null, this.token = null, this.skipHeartbeat = true, this.onopen = function() {
              }, this.onerror = function() {
              }, this.onmessage = function() {
              }, this.onclose = function() {
              }, this.pollEndpoint = this.normalizeEndpoint(t2), this.readyState = p2, this.poll();
            }
            return h(e2, [{ key: "normalizeEndpoint", value: function(e3) {
              return e3.replace("ws://", "http://").replace("wss://", "https://").replace(new RegExp("(.*)/" + L), "$1/" + A);
            } }, { key: "endpointURL", value: function() {
              return D.appendParams(this.pollEndpoint, { token: this.token });
            } }, { key: "closeAndRetry", value: function() {
              this.close(), this.readyState = p2;
            } }, { key: "ontimeout", value: function() {
              this.onerror("timeout"), this.closeAndRetry();
            } }, { key: "poll", value: function() {
              var e3 = this;
              this.readyState !== v && this.readyState !== p2 || D.request("GET", this.endpointURL(), "application/json", null, this.timeout, this.ontimeout.bind(this), function(t2) {
                if (t2) {
                  var n2 = t2.status, i2 = t2.token, o2 = t2.messages;
                  e3.token = i2;
                } else n2 = 0;
                switch (n2) {
                  case 200:
                    o2.forEach(function(t3) {
                      setTimeout(function() {
                        e3.onmessage({ data: t3 });
                      }, 0);
                    }), e3.poll();
                    break;
                  case 204:
                    e3.poll();
                    break;
                  case 410:
                    e3.readyState = v, e3.onopen(), e3.poll();
                    break;
                  case 403:
                    e3.onerror(), e3.close();
                    break;
                  case 0:
                  case 500:
                    e3.onerror(), e3.closeAndRetry();
                    break;
                  default:
                    throw new Error("unhandled poll status ".concat(n2));
                }
              });
            } }, { key: "send", value: function(e3) {
              var t2 = this;
              D.request("POST", this.endpointURL(), "application/json", e3, this.timeout, this.onerror.bind(this, "timeout"), function(e4) {
                e4 && 200 === e4.status || (t2.onerror(e4 && e4.status), t2.closeAndRetry());
              });
            } }, { key: "close", value: function(e3, t2) {
              this.readyState = m, this.onclose();
            } }]), e2;
          }(), D = function() {
            function e2() {
              c2(this, e2);
            }
            return h(e2, null, [{ key: "request", value: function(e3, t2, n2, i2, o2, r2, s2) {
              if (d.XDomainRequest) {
                var a2 = new XDomainRequest();
                this.xdomainRequest(a2, e3, t2, i2, o2, r2, s2);
              } else {
                var c3 = new d.XMLHttpRequest();
                this.xhrRequest(c3, e3, t2, n2, i2, o2, r2, s2);
              }
            } }, { key: "xdomainRequest", value: function(e3, t2, n2, i2, o2, r2, s2) {
              var a2 = this;
              e3.timeout = o2, e3.open(t2, n2), e3.onload = function() {
                var t3 = a2.parseJSON(e3.responseText);
                s2 && s2(t3);
              }, r2 && (e3.ontimeout = r2), e3.onprogress = function() {
              }, e3.send(i2);
            } }, { key: "xhrRequest", value: function(e3, t2, n2, i2, o2, r2, s2, a2) {
              var c3 = this;
              e3.open(t2, n2, true), e3.timeout = r2, e3.setRequestHeader("Content-Type", i2), e3.onerror = function() {
                a2 && a2(null);
              }, e3.onreadystatechange = function() {
                if (e3.readyState === c3.states.complete && a2) {
                  var t3 = c3.parseJSON(e3.responseText);
                  a2(t3);
                }
              }, s2 && (e3.ontimeout = s2), e3.send(o2);
            } }, { key: "parseJSON", value: function(e3) {
              if (!e3 || "" === e3) return null;
              try {
                return JSON.parse(e3);
              } catch (t2) {
                return console && console.log("failed to parse JSON response", e3), null;
              }
            } }, { key: "serialize", value: function(e3, t2) {
              var n2 = [];
              for (var i2 in e3) if (e3.hasOwnProperty(i2)) {
                var r2 = t2 ? "".concat(t2, "[").concat(i2, "]") : i2, s2 = e3[i2];
                "object" === o(s2) ? n2.push(this.serialize(s2, r2)) : n2.push(encodeURIComponent(r2) + "=" + encodeURIComponent(s2));
              }
              return n2.join("&");
            } }, { key: "appendParams", value: function(e3, t2) {
              if (0 === Object.keys(t2).length) return e3;
              var n2 = e3.match(/\?/) ? "&" : "?";
              return "".concat(e3).concat(n2).concat(this.serialize(t2));
            } }]), e2;
          }();
          D.states = { complete: 4 };
          var M = function() {
            function e2(t2) {
              var n2 = this, i2 = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {};
              c2(this, e2);
              var o2 = i2.events || { state: "presence_state", diff: "presence_diff" };
              this.state = {}, this.pendingDiffs = [], this.channel = t2, this.joinRef = null, this.caller = { onJoin: function() {
              }, onLeave: function() {
              }, onSync: function() {
              } }, this.channel.on(o2.state, function(t3) {
                var i3 = n2.caller, o3 = i3.onJoin, r2 = i3.onLeave, s2 = i3.onSync;
                n2.joinRef = n2.channel.joinRef(), n2.state = e2.syncState(n2.state, t3, o3, r2), n2.pendingDiffs.forEach(function(t4) {
                  n2.state = e2.syncDiff(n2.state, t4, o3, r2);
                }), n2.pendingDiffs = [], s2();
              }), this.channel.on(o2.diff, function(t3) {
                var i3 = n2.caller, o3 = i3.onJoin, r2 = i3.onLeave, s2 = i3.onSync;
                n2.inPendingSyncState() ? n2.pendingDiffs.push(t3) : (n2.state = e2.syncDiff(n2.state, t3, o3, r2), s2());
              });
            }
            return h(e2, [{ key: "onJoin", value: function(e3) {
              this.caller.onJoin = e3;
            } }, { key: "onLeave", value: function(e3) {
              this.caller.onLeave = e3;
            } }, { key: "onSync", value: function(e3) {
              this.caller.onSync = e3;
            } }, { key: "list", value: function(t2) {
              return e2.list(this.state, t2);
            } }, { key: "inPendingSyncState", value: function() {
              return !this.joinRef || this.joinRef !== this.channel.joinRef();
            } }], [{ key: "syncState", value: function(e3, t2, n2, i2) {
              var o2 = this, r2 = this.clone(e3), s2 = {}, a2 = {};
              return this.map(r2, function(e4, n3) {
                t2[e4] || (a2[e4] = n3);
              }), this.map(t2, function(e4, t3) {
                var n3 = r2[e4];
                if (n3) {
                  var i3 = t3.metas.map(function(e5) {
                    return e5.phx_ref;
                  }), c3 = n3.metas.map(function(e5) {
                    return e5.phx_ref;
                  }), u2 = t3.metas.filter(function(e5) {
                    return c3.indexOf(e5.phx_ref) < 0;
                  }), h2 = n3.metas.filter(function(e5) {
                    return i3.indexOf(e5.phx_ref) < 0;
                  });
                  u2.length > 0 && (s2[e4] = t3, s2[e4].metas = u2), h2.length > 0 && (a2[e4] = o2.clone(n3), a2[e4].metas = h2);
                } else s2[e4] = t3;
              }), this.syncDiff(r2, { joins: s2, leaves: a2 }, n2, i2);
            } }, { key: "syncDiff", value: function(e3, t2, n2, o2) {
              var r2 = t2.joins, s2 = t2.leaves, a2 = this.clone(e3);
              return n2 || (n2 = function() {
              }), o2 || (o2 = function() {
              }), this.map(r2, function(e4, t3) {
                var o3 = a2[e4];
                if (a2[e4] = t3, o3) {
                  var r3, s3 = a2[e4].metas.map(function(e5) {
                    return e5.phx_ref;
                  }), c3 = o3.metas.filter(function(e5) {
                    return s3.indexOf(e5.phx_ref) < 0;
                  });
                  (r3 = a2[e4].metas).unshift.apply(r3, i(c3));
                }
                n2(e4, o3, t3);
              }), this.map(s2, function(e4, t3) {
                var n3 = a2[e4];
                if (n3) {
                  var i2 = t3.metas.map(function(e5) {
                    return e5.phx_ref;
                  });
                  n3.metas = n3.metas.filter(function(e5) {
                    return i2.indexOf(e5.phx_ref) < 0;
                  }), o2(e4, n3, t3), 0 === n3.metas.length && delete a2[e4];
                }
              }), a2;
            } }, { key: "list", value: function(e3, t2) {
              return t2 || (t2 = function(e4, t3) {
                return t3;
              }), this.map(e3, function(e4, n2) {
                return t2(e4, n2);
              });
            } }, { key: "map", value: function(e3, t2) {
              return Object.getOwnPropertyNames(e3).map(function(n2) {
                return t2(n2, e3[n2]);
              });
            } }, { key: "clone", value: function(e3) {
              return JSON.parse(JSON.stringify(e3));
            } }]), e2;
          }(), N = function() {
            function e2(t2, n2) {
              c2(this, e2), this.callback = t2, this.timerCalc = n2, this.timer = null, this.tries = 0;
            }
            return h(e2, [{ key: "reset", value: function() {
              this.tries = 0, clearTimeout(this.timer);
            } }, { key: "scheduleTimeout", value: function() {
              var e3 = this;
              clearTimeout(this.timer), this.timer = setTimeout(function() {
                e3.tries = e3.tries + 1, e3.callback();
              }, this.timerCalc(this.tries + 1));
            } }]), e2;
          }();
        }]);
      });
    }
  });

  // assets/js/app.js
  var import_bootstrap_bundle = __toESM(require_bootstrap_bundle_min());

  // assets/js/column_formatter.js
  var ColumnFormater = {
    datetime(row, dtdata, dataSource) {
      var dCols = dataSource.columns.filter((v, i) => {
        return v.formatDateTime == true;
      });
      dCols.forEach((v, i) => {
        var offset = v.offset;
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data;
        });
        try {
          var str = dtdata[v.data];
          str = Date.parse(str);
          var dt = new Date(str);
          dt.setTime(dt.getTime() + (8 + offset) * 60 * 60 * 1e3);
          var edate = dt.toGMTString().split(",")[1].split(" ").splice(0, 4).join(" ");
          var etime = dt.toLocaleTimeString();
          $("td:eq(" + index + ")", row).html(
            `<span class="text-muted fw-bold">` + edate + `</span>

          <small class="fw-bold text-primary">
              ` + etime + `          
          </small>
             `
          );
        } catch (e) {
          console.log(e);
        }
      });
    },
    custom(row, dtdata, dataSource) {
      var showChildCols = dataSource.columns.filter((v, i) => {
        return v.customized == true;
      });
      showChildCols.forEach((v, i) => {
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data && x.xdata == v.xdata;
        });
        try {
          $("td:eq(" + index + ")", row).html(v.xdata.formatFn(dtdata, parseInt(row.getAttribute("aria-index"))));
        } catch (e) {
          console.log(e);
        }
      });
    },
    img(row, dtdata, dataSource) {
      var showBooleanCols = dataSource.columns.filter((v, i) => {
        return v.showImg == true;
      });
      showBooleanCols.forEach((v, i) => {
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data;
        });
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
        </div>`;
          $("td:eq(" + index + ")", row).html(ic);
        } catch (e) {
        }
      });
    },
    progress(row, dtdata, dataSource) {
      var showProgressCols = dataSource.columns.filter((v, i) => {
        return v.showProgress == true;
      });
      showProgressCols.forEach((v, i) => {
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data;
        });
        try {
          var content = dtdata[v.data];
          var progressList = v.progress;
          var pg = [];
          var perc2 = 1 / progressList.length * 100;
          var check_index = progressList.findIndex((v2, i2) => {
            return v2 == content;
          });
          progressList.forEach((progress, pi) => {
            if (check_index >= pi) {
              var bar = `<div class="progress-bar bg-warning " role="progressbar" style="width: ` + perc2 + `%;" ></div>
              `;
            } else {
              var bar = `<div class="progress-bar " role="progressbar" style="width: ` + perc2 + `%;" ></div>
              `;
            }
            pg.push(bar);
          });
          p = `
          <small>` + content + `</small>
          <div class="progress gap-1">
          ` + pg.join("") + `
          </div>
        `;
          $("td:eq(" + index + ")", row).html(p);
        } catch (e) {
        }
      });
    },
    subtitle(row, dtdata, dataSource) {
      var showSubtitleCols = dataSource.columns.filter((v, i) => {
        return v.showSubtitle == true;
      });
      showSubtitleCols.forEach((v, i) => {
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data;
        });
        var subindex = 0;
        subindex = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.subtitle;
        });
        try {
          var content = dtdata[v.data];
          var sub = dtdata[v.subtitle];
          if (dataSource.columns[index].showChild) {
            content = dtdata[v.xdata.child][v.xdata.data];
          }
          if (dataSource.columns[index].formatFloat) {
            content = currencyFormat(content);
          }
          if (dataSource.columns[subindex].formatFloat) {
            sub = currencyFormat(sub);
          }
          if (dataSource.columns[subindex].showBoolean) {
            if (dtdata[v.subtitle] == true) {
              sub = `<i class="text-success fa fa-check"></i>`;
            } else {
              sub = `<i class="text-danger fa fa-times"></i>`;
            }
          }
          $("td:eq(" + index + ")", row).html(`<span class="pe-2">` + content + `</span>
          <small class="text-muted text-truncate" style="max-width: 24vw;display: block;">` + sub + `</small>`);
        } catch (e) {
        }
      });
    },
    bool(row, dtdata, dataSource) {
      var showBooleanCols = dataSource.columns.filter((v, i) => {
        return v.showBoolean == true;
      });
      showBooleanCols.forEach((v, i) => {
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data;
        });
        try {
          var ic;
          if (dtdata[v.data] == true) {
            ic = `<i class="text-success fa fa-check"></i>`;
          } else {
            ic = `<i class="text-danger fa fa-times"></i>`;
          }
          $("td:eq(" + index + ")", row).html(ic);
        } catch (e) {
        }
      });
    },
    json(row, dtdata, dataSource) {
      var showJsonCols = dataSource.columns.filter((v, i) => {
        return v.showJson == true;
      });
      showJsonCols.forEach((v, i) => {
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data;
        });
        try {
          $("td:eq(" + index + ")", row).html(`<div aria-data='' class="jsv` + dataSource.makeid.id + `" id="` + v.data + dtdata.id + `"></div>`);
        } catch (e) {
        }
      });
    },
    child(row, dtdata, dataSource) {
      var showChildCols = dataSource.columns.filter((v, i) => {
        return v.showChild == true;
      });
      showChildCols.forEach((v, i) => {
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data && x.xdata == v.xdata;
        });
        try {
          $("td:eq(" + index + ")", row).html(dtdata[v.xdata.child][v.xdata.data]);
          if (v.xdata.showImg) {
            try {
              console.log("attemp to show img...");
              if (dtdata[v.xdata.child][0] != null) {
                var ic;
                ic = `
              <div style="background-size: cover !important; background-image: url('` + dtdata[v.xdata.child][0][v.xdata.data] + `') !important; 
              height: 80px;width: 80px" class="rounded-circle text-center 
              bg-primary d-flex align-items-center justify-content-center text-white">
              </div>`;
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
      });
    },
    float(row, dtdata, dataSource) {
      var formatFloatCols = dataSource.columns.filter((v, i) => {
        return v.formatFloat == true;
      });
      formatFloatCols.forEach((v, i) => {
        var index = 0;
        index = dataSource.columns.findIndex((x, i2) => {
          return x.data == v.data;
        });
        try {
          $("td:eq(" + index + ")", row).html(currencyFormat(dtdata[v.data]));
        } catch (e) {
        }
      });
    },
    dataFormatter(dtdata, v) {
      var input2 = null;
      var formatType = ["formatFloat", "showBoolean", "formatDateTime", "showImg", "showChild"];
      var selectedKey = -1;
      var keys = Object.keys(v);
      formatType.forEach((f, ii) => {
        if (keys.indexOf(f) > 0) {
          selectedKey = ii;
        }
      });
      console.log(formatType[selectedKey]);
      switch (formatType[selectedKey]) {
        case "formatFloat":
          input2 = this.currencyFormat(dtdata[v.data]);
          break;
        case "showImg":
          try {
            console.log("simmg");
            input2 = `
        <div style="background-size: cover !important; background-image: url('` + dtdata[v.data] + `') !important; 
        height: 80px;width: 80px" class="rounded-circle text-center 
        bg-primary d-flex align-items-center justify-content-center text-white">
        </div>`;
          } catch (e) {
            console.log(e);
          }
          break;
        case "showChild":
          try {
            input2 = dtdata[v.xdata.child][v.xdata.data];
            if (v.xdata.showImg) {
              try {
                console.log("attemp to show img...");
                if (dtdata[v.xdata.child][0] != null) {
                  input2 = `
                <div style="background-size: cover !important; background-image: url('` + dtdata[v.xdata.child][0][v.xdata.data] + `') !important; 
                height: 80px;width: 80px" class="rounded-circle text-center 
                bg-primary d-flex align-items-center justify-content-center text-white">
                </div>`;
                }
              } catch (e) {
              }
            }
            if (v.xdata.formatFloat) {
              input2 = currencyFormat(dtdata[v.xdata.child][v.xdata.data]);
            }
          } catch (e) {
          }
          break;
        case "showBoolean":
          try {
            var ic;
            if (dtdata[v.data] == true) {
              ic = `<i class="text-success fa fa-check"></i>`;
            } else {
              ic = `<i class="text-danger fa fa-times"></i>`;
            }
            input2 = ic;
          } catch (e) {
          }
          break;
        case "formatDateTime":
          var str = dtdata[v.data];
          str = Date.parse(str);
          var dt = new Date(str);
          dt.setTime(dt.getTime() + 8 * 60 * 60 * 1e3);
          var edate = dt.toGMTString().split(",")[1].split(" ").splice(0, 4).join(" ");
          var etime = dt.toLocaleTimeString();
          input2 = `<span class="text-muted fw-bold">` + edate + `</span>

              <small class="fw-bold text-primary">
                  ` + etime + `          
              </small>
                 `;
          break;
        default:
          input2 = dtdata[v.data];
      }
      if (input2 == null) {
        input2 = dtdata[v.data];
      }
      return input2;
    },
    formatDate() {
      $(" .format-int, .format-integer").each((i, v) => {
        var prefix = "";
        if ($(v).html().split(" ").includes("DR")) {
          prefix = "DR";
        }
        if ($(v).html().split(" ").includes("CR")) {
          prefix = "CR";
        }
        var content = $(v).html();
        if (parseFloat(content) > 0) {
          var span = `<span class="text-end" >` + prefix + this.currencyFormat(parseFloat(content)).replace(".00", "") + `</span>`;
          $(v).html(span);
        } else if (parseFloat(content) == 0) {
          $(v).html("0.00");
        } else {
          $(v).html(content);
        }
      });
      $(".format_float, .format-float").each((i, v) => {
        var prefix = "";
        if ($(v).html().split(" ").includes("DR")) {
          prefix = "DR";
        }
        if ($(v).html().split(" ").includes("CR")) {
          prefix = "CR";
        }
        if ($(v).html().includes("-")) {
          prefix = "-";
        }
        var content = $(v).html().replace("-", "");
        if (parseFloat(content) > 0) {
          var span = `<span class="text-end" >` + prefix + this.currencyFormat(parseFloat(content)) + ` </span>`;
          $(v).html(span);
        } else if (parseFloat(content) == 0) {
          $(v).html("0.00");
        } else {
          $(v).html(content);
        }
      });
      $(".format_date").each((i, v) => {
        var d = $(v).html();
        if (Date.parse(d) > 0) {
          var date = new Date(d);
          var day;
          if (date.getDate().toString().length > 1) {
            day = date.getDate();
          } else {
            day = "0" + date.getDate();
          }
          var month;
          if ((date.getMonth() + 1).toString().length > 1) {
            month = date.getMonth() + 1;
          } else {
            month = "0" + (date.getMonth() + 1);
          }
          $(v).html("<b>" + day + "-" + month + "-" + date.getFullYear() + "</b>");
        } else {
          $(v).html(d);
        }
      });
      $(".format_datetime").each((i, v) => {
        var edate, offset = 0;
        if ($(v).attr("aria-offset") != null) {
          offset = parseInt($(v).attr("aria-offset"));
        }
        var str = $(v).html();
        str = Date.parse($(v).html().replace(" ", ""));
        var dt = new Date(str);
        dt.setTime(dt.getTime() + 8 * 60 * 60 * 1e3);
        try {
          edate = dt.toGMTString().split(",")[1].split(" ").splice(1, 3).join(" ");
        } catch (e) {
          console.log(e);
        }
        var etime = dt.toLocaleTimeString();
        $(v).html(`` + edate + ` ` + etime);
      });
      $(".is_posted").each((i, v) => {
        var d = $(v).html();
        if (d == "true") {
          $(v).html(`
                <i class="text-success fa fa-check"></i>
                `);
        }
        if (d == "false") {
          $(v).html(`
                <i class="text-danger fa fa-exclamation-circle"></i>
                `);
        }
      });
    },
    currencyFormat(num) {
      if (num == null) {
        return "0.00";
      } else {
        return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
      }
    },
    capitalize(string) {
      return string.replace(/^\w/, (c2) => c2.toUpperCase());
    }
  };

  // assets/js/phx_app.js
  var phxApp_ = {
    Page: {
      createTable(id, dom) {
        var html2 = `
            <div class="table-responsive">
                <table class="table"  style="width: 100%;" id="` + id + `">
                    <thead></thead>
                    <tbody></tbody>
                </table>
            </div>
    `;
        $(dom).append(html2);
      }
    },
    e: null,
    j: [],
    route_names: [
      {
        html: "landing.html",
        title: "Home",
        route: "/home",
        public: true
      }
    ],
    render(componentName) {
      commerceApp_.components[componentName]();
    },
    rowData(params) {
      var dt = params.dataSource;
      window.currentSelector = dt.tableSelector;
      var table = dt.table;
      var r = table.row(params.row);
      var rowData = table.data()[params.index];
      return rowData;
    },
    override(j) {
      memberApp_.override(j);
    },
    updateUser(j) {
      memberApp_.updateUser(j);
    },
    login(dom) {
      memberApp_.login(dom);
    },
    logout() {
      memberApp_.logout();
    },
    user: null,
    addItem(id) {
      var data2 = phxApp_.api("get_product", { id });
      data2.payInstalment = true;
      commerceApp_.k(data2);
      commerceApp_.components["updateCart"]();
      commerceApp_.components["cartItems"]();
    },
    filterItemsByName(itemName) {
      return commerceApp_.filterItemsByName(itemName);
    },
    hasCartItems() {
      console.log("checking...");
      console.log(commerceApp_.hasCartItems());
      return commerceApp_.hasCartItems() > 0;
    },
    merchantCheckout(dom) {
      memberApp_.merchantCheckout(dom);
    },
    redeem(dom) {
      memberApp_.redeem(dom);
    },
    upgrade(dom) {
      memberApp_.upgrade(dom);
    },
    linkRegister(dom) {
      memberApp_.linkRegister(dom);
    },
    register(dom) {
      memberApp_.register(dom);
    },
    formatDate() {
      ColumnFormater.formatDate();
    },
    ping() {
      console.log("tell ping o");
    },
    reinit() {
      $(".dataTable").each((i, v) => {
        if (v.offsetParent != null) {
          var phxModel = window.phoenixModels.filter((dv, di) => {
            return dv.tableSelector == "#" + v.id;
          })[0];
          phxModel.reload();
        }
      });
    },
    evalTitle(label) {
      if (localStorage.getItem("default-lang") == "cn") {
        switch (label.replace(" ", "")) {
          case "Home":
            label = "\u9996\u9875";
            break;
          case "Profile":
            label = "\u4E2A\u4EBA";
            break;
          case "Upgrade":
            label = "\u5347\u7EA7";
            break;
          case "Restocks":
            label = "\u6734\u8D27";
            break;
          case "Registrations":
            label = "\u5BA1\u6838";
            break;
          case "Sales":
            label = "\u4E1A\u7EE9";
            break;
          case "Commissions":
            label = "\u4F63\u91D1";
            break;
          default:
            label = label;
        }
      }
      return label;
    },
    async navigateTo(route, additionalParamString) {
      if (route == null) {
        route = window.location.pathname;
      }
      var current_pattern = route.split("/").filter((v, i) => {
        return v != "";
      });
      var match_1 = this.route_names.filter((rroute, i) => {
        var z = rroute.route.split("/").filter((v, i2) => {
          return v != "";
        });
        if (z[z.length - 1].includes(":")) {
          return z.length == current_pattern.length;
        } else {
          return z.length == current_pattern.length && z[z.length - 1] == current_pattern[z.length - 1];
        }
      });
      var match_2 = match_1.filter((rroute, i) => {
        var z = rroute.route.split("/").filter((v, i2) => {
          return v != "";
        });
        return z[0] == current_pattern[0];
      });
      this.hide();
      memberApp_.restoreUser();
      if (match_2.length > 0) {
        var params = {};
        match_2.forEach((rroute, i) => {
          var z = rroute.route.split("/").forEach((v, ii) => {
            if (v.includes(":")) {
              params[v.replace(":", "")] = current_pattern[ii - 1];
            }
          });
        });
        console.info(match_2);
        if (match_2[0].public) {
        } else {
          await memberApp_.restoreUser();
          console.log("resting?");
          if (memberApp_.user != null) {
          } else {
            phxApp_.navigateTo("/logout");
          }
        }
        window.pageParams = params;
        var xParamString = "";
        if (additionalParamString == null) {
          xParamString = "";
        } else {
          xParamString = additionalParamString;
        }
        if (window.back) {
          window.back = false;
        } else {
          var stateObj = {
            route,
            fn: `phxApp.navigateTo('` + route + `', '` + xParamString + `')`,
            params
          };
          window.stateObj = stateObj;
          window.matchTitle = match_2[0].title;
          window.matchRoute = route;
          if (Object.keys(params).includes("title")) {
            history.pushState(stateObj, evalTitle(params.title), route);
            $("title").html(this.evalTitle(params.title));
          } else {
            history.pushState(stateObj, this.evalTitle(match_2[0].title), route);
            $("title").html(this.evalTitle(match_2[0].title));
          }
        }
        var nav = this.html("blog_nav.html");
        var footer_modals = this.html("footer_modals.html");
        var html2 = this.html(match_2[0].html);
        var initPage = `
      <div class="page-content pb-0">
        ` + html2 + `
      </div>
        ` + footer_modals + `
          `;
        var keys = Object.keys(match_2[0]);
        if (keys.includes("skipNav")) {
          $("#content").html(initPage);
          this.navigateCallback();
        } else {
          if (keys.includes("customNav")) {
            var nav = this.html(match_2[0].customNav);
          }
          $("#content").html(nav);
          $("#content").append(initPage);
          this.navigateCallback();
        }
        return match_2[0];
      } else {
        console.info(match_1);
        var nav = this.html("blog_nav.html");
        var footer_modals = this.html("footer_modals.html");
        var html2 = this.html("landing.html");
        var initPage = `
      <div class="page-content pb-0">
        ` + html2 + `
      </div>        ` + footer_modals;
        $("#content").html(nav);
        $("#content").append(initPage);
        this.navigateCallback();
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
        drawFn: () => {
        },
        autoClose: true
      };
      var keys = Object.keys(default_options);
      keys.forEach((v, i) => {
        this[v] = default_options[v];
      });
      keys.forEach((v, i) => {
        if (options[v] != null) {
          this[v] = options[v];
        }
      });
      $(this.selector).find(this.title).customHtml(this.header);
      $(this.selector).find(this.body).customHtml(this.content);
      $(this.selector).find(this.foot).customHtml(this.footer);
      $(this.selector).modal("show");
      this.drawFn();
      if (this.autoClose) {
        setTimeout(() => {
          $(this.selector).modal("hide");
        }, 5e3);
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
        drawFn: () => {
        },
        autoClose: true
      };
      var keys = Object.keys(default_options);
      keys.forEach((v, i) => {
        this[v] = default_options[v];
      });
      keys.forEach((v, i) => {
        if (options[v] != null) {
          this[v] = options[v];
        }
      });
      $(this.selector).find(this.title).customHtml(this.header);
      $(this.selector).find(this.body).customHtml(this.content);
      $(this.selector).toast("show");
      this.drawFn();
      if (this.autoClose) {
      }
    },
    notify(message, options) {
      if (options == null) {
        options = {};
      }
      var default_options = {
        delay: 2e3,
        type: "info"
      };
      var keys = Object.keys(default_options);
      keys.forEach((v, i) => {
        this[v] = default_options[v];
      });
      keys.forEach((v, i) => {
        if (options[v] != null) {
          this[v] = options[v];
        }
      });
      var obj = {};
      var message_obj = {};
      if (typeof message == "object") {
        message_obj = message;
      } else {
        message_obj = {
          message
        };
      }
      var default_obj = {
        message: "Your text here",
        title: "System Message:",
        icon: "fa fa-exclamation-circle"
      };
      var keys = Object.keys(default_obj);
      keys.forEach((v, i) => {
        obj[v] = default_obj[v];
      });
      keys.forEach((v, i) => {
        if (message_obj[v] != null) {
          obj[v] = message_obj[v];
        }
      });
      try {
        if (typeof $.notify === "function") {
          console.log(options);
          $.notify(obj, options);
        } else {
          this.toast({
            content: obj.message,
            header: obj.title
          });
        }
      } catch (e) {
        this.toast({
          content: obj.message,
          header: obj.title
        });
      }
    },
    reflect(formData) {
      var object = {};
      formData.forEach((value, key) => {
        console.log(key);
        var childMap = {};
        if (key.includes("[")) {
          console.log("has child");
          var parent = key.split("[")[0];
          var child = key.split("[")[1].split("]")[0];
          childMap[child] = value;
          object[parent] = {
            ...object[parent],
            ...childMap
          };
        } else {
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
      var failed_inputs = $(selector).find("[name]").filter((i, v) => {
        $(v).removeClass("is-invalid");
        return v.checkValidity() == false;
      });
      if (failed_inputs.length > 0) {
        var labels = [];
        failed_inputs.map((v, i) => {
          $(i).addClass("is-invalid");
          var label = $(i).closest(".input-style").find("label div").html();
          if (label == null) {
            label = $(i).attr("name");
          }
          labels.push(label);
        });
        phxApp_.notify("This input: " + labels.join(", ") + " is not valid!", {
          type: "danger"
        });
      } else {
        successCallback();
      }
    },
    form(dom, scope, successCallback, failedCallback, appendMap) {
      phxApp_.show();
      var prefix = "", formData = new FormData($(dom)[0]);
      formData.append("scope", scope);
      if (appendMap != null) {
        var keys = Object.keys(appendMap);
        keys.forEach((k, i) => {
          formData.append(k, appendMap[k]);
        });
      }
      if (scope == "login") {
        prefix = "/login";
      }
      var csrfToken = this.w();
      $.ajax({
        url: "/api/webhook" + prefix,
        dataType: "json",
        headers: {
          "Authorization": "Basic " + (phxApp_.user != null ? phxApp_.user.token : null),
          "x-csrf-token": csrfToken
        },
        method: "POST",
        enctype: "multipart/form-data",
        processData: false,
        // tell jQuery not to process the data
        contentType: false,
        data: formData
      }).done(function(j) {
        phxApp_.hide();
        if (j.status == "ok") {
          phxApp_.notify("Added!", {
            type: "success"
          });
          try {
            if (j.res != null) {
              successCallback(j.res);
            }
          } catch (e) {
          }
        } else {
          if (j.reason != null) {
            phxApp_.notify("Not added! " + j.reason, {
              type: "danger"
            });
          } else {
            phxApp_.notify("Not added!", {
              type: "danger"
            });
          }
        }
      }).fail(function(e) {
        if (e.status == 403) {
          memberApp_.logout();
        }
        phxApp_.notify("Not added!", {
          type: "danger"
        });
      });
    },
    html(page) {
      $(".modal-body").each((i, v) => {
        $(v).html("");
      });
      var langPrefix3 = "v2";
      function evalCountry2(countryName) {
        var prefix = "v2";
        if (countryName == "Thailand") {
          prefix = "th";
        }
        if (countryName == "Vietnam") {
          prefix = "vn";
        }
        if (countryName == "China") {
          prefix = "cn";
        }
        return prefix;
      }
      if (localStorage.region != null) {
        langPrefix3 = evalCountry2(localStorage.region);
      }
      var res = "";
      $.ajax({
        async: false,
        method: "get",
        url: "/html/" + langPrefix3 + "/" + page
      }).done((j) => {
        res = j;
      });
      return res;
    },
    token: null,
    w(renew) {
      if (this.token == null) {
        this.token = $("input[name='_csrf_token_ori']").val();
      } else if (renew) {
        this.token = $("input[name='_csrf_token_ori']").val();
      } else {
        return this.token;
      }
    },
    api(scope, params, failed_callback, successCallback) {
      var res = "";
      var csrfToken = this.w();
      $.ajax({
        async: false,
        method: "get",
        headers: {
          "Authorization": "Basic " + (phxApp_.user != null ? phxApp_.user.token : null),
          "X-CSRF-Token": csrfToken
        },
        url: "/api/webhook?scope=" + scope,
        data: params
      }).done((j) => {
        console.log(j);
        if (successCallback != null) {
          successCallback(j);
        }
        res = j;
      }).fail(function(e) {
        if (e.status == 403) {
          memberApp_.logout();
        }
        try {
          phxApp_.notify("Not Added! reason: " + e.responseJSON.reason, {
            type: "danger"
          });
        } catch (e2) {
          phxApp_.notify("Ops, somethings' not right!", {
            type: "danger"
          });
        }
        phxApp_.show();
        setTimeout(() => {
          if (failed_callback != null) {
            failed_callback();
          }
          phxApp_.hide();
        }, 500);
      });
      return res;
    },
    post(scope, params, failed_callback, successCallback) {
      var res = "";
      var csrfToken = $("input[name='_csrf_token_ori']").val();
      var data2 = { ...params, ...{ _csrf_token: csrfToken } };
      console.log(data2);
      $.ajax({
        async: false,
        method: "post",
        headers: {
          "Authorization": "Basic " + (phxApp_.user != null ? phxApp_.user.token : null),
          "X-CSRF-Token": csrfToken
        },
        url: "/api/webhook?scope=" + scope,
        data: data2
      }).done((j) => {
        if (successCallback != null) {
          successCallback(j);
        }
        res = j;
      }).fail(function(e) {
        if (e.status == 403) {
        }
        phxApp_.notify("Ops, somethings' not right!", {
          type: "danger"
        });
        setTimeout(() => {
          if (failed_callback != null) {
            failed_callback();
          }
          this.hide();
        }, 500);
      });
      return res;
    },
    evaluateLang() {
    },
    toTop() {
      $("body")[0].scrollIntoView();
    },
    async putToken() {
      var csrfToken = this.w(true);
      if ($("input#need-token")) {
        $("input[name='_csrf_token']").val($("input[name='_csrf_token_ori']").val());
      }
    },
    evalCart() {
      if (window.location.pathname.includes("merchant")) {
        $(".showMcart").toggleClass("d-none");
        $(".showCart").toggleClass("d-none");
      }
    },
    async navigateCallback() {
      memberApp_.restoreUser();
      commerceApp_.restoreCart();
      commerceApp_.restoreCart(true);
      this.user = memberApp_.user;
      if (this.user != null) {
        this.user.wallets = null;
      }
      try {
        commerceApp_.render();
      } catch (e) {
      }
      this.evaluateLang();
      this.toTop();
      this.hide();
      this.putToken();
      this.evalCart();
    },
    show() {
      console.log("drop shadow..");
      $(".wrapper-ring").show();
      setTimeout(() => {
        $(".wrapper-ring").hide();
      }, 1e3);
    },
    hide() {
      console.log("hide shadow..");
      try {
        $(".wrapper-ring").hide();
      } catch (e) {
      }
    },
    repopulateFormInput(data2, formSelector) {
      console.log(data2);
      var inputs = $(formSelector).find("[name]");
      $(inputs).each(function(i, v) {
        var name = $(v).attr("aria-label");
        if (name == null) {
          name = $(v).attr("name");
        }
        var hidden_value = $(v).attr("aria-value");
        var parent = name.split("[")[0];
        var child = name.replace("[", "").replace("]", "").replace(parent, "");
        if ($(v).prop("localName") == "select") {
          console.log("is select");
          if (name.includes("[")) {
            $(v).val(data2[parent][child]);
          } else {
            $(v).val(data2[name]);
          }
        } else if (hidden_value != null) {
          $(v).val(hidden_value);
        } else if ($(v).hasClass("code")) {
          try {
            $(v).val(data2[name]);
            var hid_inpt = document.createElement("input");
            hid_inpt.setAttribute("type", "hidden");
            hid_inpt.setAttribute("name", $(v).attr("name"));
            $(v).after(hid_inpt);
            var editor = ace.edit($("textarea")[0], {
              mode: "ace/mode/html",
              selectionStyle: "text"
            });
            editor.resize();
            window.editor = editor;
            editor.session.setUseWrapMode(true);
            editor.session.on("change", function(delta) {
              $(hid_inpt).val(window.editor.getValue());
              console.log("ace here");
            });
          } catch (e) {
            console.log(e);
            $(v).val(data2[name]);
          }
        } else {
          if ($(v).attr("type") == "checkbox") {
            console.log("got data?");
            console.log(data2[name]);
            if ($(v).hasClass("many_2_many")) {
              var id = parseInt(v.name.split("][")[1].split("]")[0]);
              try {
                var res = data2[name].filter((v2, i2) => {
                  return v2.id == id;
                });
                if (res.length > 0) {
                  $(v).prop("checked", data2[name]);
                }
              } catch (e) {
                console.log(e);
                $(v).prop("checked", false);
              }
            } else {
              $(v).prop("checked", data2[name]);
            }
          } else {
            if (data2 != null) {
              console.log(name);
              console.log("name: " + name + ", data: " + data2[name]);
              if (name.includes(".")) {
                try {
                  var module_name = $(v).closest("form").attr("id");
                  var assoc_val = name.split(".");
                  if (assoc_val.length == 2) {
                    $(v).val(data2[assoc_val[0]][assoc_val[1]]);
                    $(v).parent().append(`<input type='hidden' value="` + data2[assoc_val[0]]["id"] + `" name="` + module_name + `[` + assoc_val[0] + `][id]"></input>`);
                  }
                  if (assoc_val.length == 3) {
                    $(v).val(data2[assoc_val[0]][assoc_val[1]][assoc_val[2]]);
                    $(v).parent().append(`<input type='hidden' value="` + data2[assoc_val[0]]["id"] + `" name="` + module_name + `[` + assoc_val[0] + `][id]"></input>`);
                  }
                  if (assoc_val.length == 1) {
                    $(v).val(data2[assoc_val[0]]);
                    $(v).parent().append(`<input type='hidden' value="` + data2[assoc_val[0]]["id"] + `" name="` + module_name + `[` + assoc_val[0] + `][id]"></input>`);
                  }
                } catch (e) {
                  console.log(e);
                  $(v).val(data2[name]);
                }
              } else if (name.includes("[")) {
                try {
                  $(v).val(data2[parent][child]);
                } catch (e) {
                  console.log(e);
                  $(v).val(data2[name]);
                }
              } else if (name == "_csrf_token") {
                var toke = $("input[name='_csrf_token_ori']").val();
                $(v).val(toke);
              } else {
                try {
                  $(v).val(data2[name]);
                } catch (e) {
                  console.log(e);
                  console.log("missing dom?");
                }
              }
            } else {
              console.log("name: " + name + ", data: ?");
            }
          }
        }
      });
    },
    generateInputs(j, v, object, qv) {
      var input2 = "", alt_class = "col-12 col-lg-6", label_title = v.charAt(0).toUpperCase() + v.slice(1);
      if (typeof qv == "object") {
        if (qv.alt_name != null) {
          label_title = qv.alt_name;
        }
        if (qv.alt_class != null) {
          alt_class = qv.alt_class;
        }
      }
      var translation_map = Object.keys(translationRes);
      var label_title = translation_map.reduce((acc, key) => {
        var regex = new RegExp(key, "g");
        return acc.replace(regex, translationRes[key]);
      }, label_title);
      switch (j[v]) {
        case "string":
          input2 = `<div class="` + alt_class + `">
                      <div class="ps-1 py-2">` + label_title + `</div>
                      <div class="col-sm-12">
                        <div class="form-group bmd-form-group">
                          <input type="text" aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control">
                        </div>
                      </div>
                    </div>`;
          break;
        case "boolean":
          input2 = `<div class="row d-flex align-items-center ">
                      <label class="offset-lg-1 col-sm-3 col-form-label text-start label-checkbox">` + label_title + `</label>
                      <div class="col-sm-6 checkbox-radios">
                        <div class="form-check">
                          <label class="form-check-label">
                            <input class="form-check-input" type="checkbox" aria-label="` + v + `" name="` + object + `[` + v + `]" value=""> This ` + v + `
                            <span class="form-check-sign">
                              <span class="check"></span>
                            </span>
                          </label>
                        </div>
                        
                      </div>
                    </div>`;
          break;
        case "integer":
          if (v.includes("id")) {
            input2 = '<input  aria-label="' + v + '" name="' + object + "[" + v + ']" type="hidden" class="form-control" value="0">';
          } else if (v == "id ") {
            input2 = '<input  aria-label="' + v + '" name="' + object + "[" + v + ']" type="hidden" class="form-control" value="0">';
          } else {
            input2 = `<div class="` + alt_class + `">
                      <div class="ps-1 py-2">` + label_title + `</div>
                      <div class="col-sm-12">
                        <div class="form-group bmd-form-group">
                          <input type="number" aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control">
                        </div>
                      </div>
                    </div>`;
          }
          break;
        case "date":
          input2 = `<div class="` + alt_class + `">
                      <div class="ps-1 py-2">` + label_title + `</div>
                      <div class="col-sm-12">
                        <div class="form-group">
                          <input type="text" aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control datepicker">
                        </div>
                      </div>
                    </div>`;
          break;
        case "naive_datetime":
          input2 = `<div class="` + alt_class + `">
                      <div class="ps-1 py-2">` + label_title + `</div>
                      <div class="col-sm-12">
                        <div class="form-group bmd-form-group">
                          <input type="text" aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control datetimepicker">
                        </div>
                      </div>
                    </div>`;
          break;
        default:
          if (v == "id" || v.includes("_id")) {
            input2 = '<input  aria-label="' + v + '" name="' + object + "[" + v + ']" type="hidden" class="form-control" value="0">';
          } else {
            input2 = `<div class="` + alt_class + `">
                      <div class="ps-1 py-2">` + label_title + `</div>
                      <div class="col-sm-12">
                        <div class="form-group bmd-form-group">
                          <input type="text" aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control">
                        </div>
                      </div>
                    </div>`;
          }
      }
      if (typeof qv == "object") {
        var selections = [];
        if (qv.selection != null) {
          var live_search = "";
          var multiple = "";
          if (qv.live_search != null) {
            if (qv.live_search) {
              live_search = `data-live-search="true"`;
            }
          }
          if (qv.multiple != null) {
            if (qv.multiple) {
              multiple = "multiple";
            }
          }
          $(qv.selection).each(function(index, selection) {
            var name;
            var vall;
            if (typeof selection == "object") {
              name = selection.name;
              vall = selection.id;
            } else {
              name = selection;
              vall = selection;
            }
            selections.push('<option value="' + vall + '">' + name + "</option>");
          });
          input2 = `<div class="` + alt_class + `">
                      <div class="ps-1 py-2">` + label_title + `</div>
                      <div class="col-sm-12">
                        <div class="form-group">
                         <select ` + multiple + ` ` + live_search + `aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control selectpicker" >
                         ` + selections.join("") + `
                         </select>
                        </div>
                      </div>
                    </div>`;
        }
        if (qv.binary) {
          input2 = `<div class="` + alt_class + `">
                      <div class="ps-1 py-2">` + label_title + `</div>
                      <div class="col-sm-12">
                        <div class="form-group bmd-form-group">
                          <textarea rows=12 cols=12 aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control"></textarea>
                        </div>
                      </div>
                    </div>`;
        }
        if (qv.placeholder) {
          input2 = `<div class="` + alt_class + `">
                      ` + qv.placeholder + `
                    </div>`;
        }
        if (qv.code) {
          input2 = `<div class="row">
                      <label class="col-sm-3 col-form-label text-end">` + label_title + `</label>
                      <div class="col-sm-9">
                        <div class="form-group bmd-form-group">
                          <textarea rows=4 cols=12 aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control code"></textarea>
                        </div>
                      </div>
                    </div>`;
        }
        if (qv.checkboxes != null) {
          var checkboxes = [];
          qv.checkboxes.sort(function(b, a) {
            return b.name.localeCompare(a.name);
          });
          $(qv.checkboxes).each((i, checkbox) => {
            var c2 = `
                    <div class="form-check">
                      <label class="text-capitalize">
                        <input aria-label="` + v + `" class="form-check-input many_2_many" type="checkbox" name="` + object + "[" + v + `][` + checkbox.id + `]"  value="true"> ` + checkbox.name + `
                        <span class="form-check-sign">
                          <span class="check"></span>
                        </span>
                      </label>
                    </div>`;
            checkboxes.push(c2);
          });
          input2 = `<div class="row">
                      <label class="col-sm-2 col-form-label text-end">` + label_title + `</label>
                      <div class="col-sm-8">
                        <div class="form-group bmd-form-group">
                          ` + checkboxes.join("") + `
                        </div>
                      </div>
                    </div>`;
        }
        if (qv.upload) {
          input2 = `<div class="` + alt_class + `">
                      <div class="pb-1 pt-1 ps-1 text-start">` + label_title + `</div>
                      <div class="col-sm-12">
                        
                        <img style="display: none;" id="myImg" src="#" alt="your image" width=300>
                          <input style="padding-top: 2vh;" type="file" aria-label="` + v + `" name="` + object + `[` + v + `]" class="">
                        
                      </div>
                    </div>`;
        }
        if (qv.editor) {
          input2 = `<div class="` + alt_class + `">
              <div class="form-group bmd-form-group">
              <label class="bmd-label-floating my-2">` + label_title + `</label>
                  <textarea id="editor1" rows=10 cols=12 aria-label="` + v + `" name="` + object + "[" + v + `]" class="form-control" ></textarea>
              </div>
          </div>`;
        }
        if (qv.datetime) {
          input2 = `<div class="row">
                      <label class="offset-lg-1 col-sm-3 col-form-label text-start">` + label_title + `</label>
                      <div class="col-sm-6">
                        <div class="form-group bmd-form-group">
                          <input type="datetime-local" aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control datepicker">
                        </div>
                      </div>
                    </div>`;
        }
        if (qv.date) {
          input2 = `<div class="row">
                      <label class="offset-lg-1 col-sm-3 col-form-label text-start">` + label_title + `</label>
                      <div class="col-sm-6">
                        <div class="form-group bmd-form-group">
                          <input type="date" aria-label="` + v + `" name="` + object + `[` + v + `]" class="form-control datepicker">
                        </div>
                      </div>
                    </div>`;
        }
        if (qv.alias) {
          var assoc_val = v.split(".");
          console.log("not sure if onclick");
          if (qv.onClickFn != null) {
            if (assoc_val.length == 2) {
              input2 = `<div class="` + alt_class + `">
                        <div class="pb-1 pt-1 ps-1 text-start">` + label_title + `</div>
                        <div class="row gx-0">
                          <div class="col-10">
                            <div class="form-group bmd-form-group">
                              <input type="text" aria-label="` + v + `" name="` + object + `[` + assoc_val[0] + `][` + assoc_val[1] + `]" class="form-control">
                            </div>
                          </div>
                          <div class="col-2">
                            <div class="btn btn-outline-primary" onclick="` + qv.onClickFn + `">Change</div>
                          </div>
                        </div>
                      </div>`;
            }
            if (assoc_val.length == 3) {
              input2 = `<div class="` + alt_class + `">
                        <div class="pb-1 pt-1 ps-1 text-start">` + label_title + `</div>
                        <div class="row">
                          <div class="col-10">
                            <div class="form-group bmd-form-group">
                              <input type="text" aria-label="` + v + `" name="` + object + `[` + assoc_val[0] + `][` + assoc_val[1] + `][` + assoc_val[2] + `]" class="form-control">
                            </div>
                          </div>
                          <div class="col-2">
                            <div class="btn btn-outline-primary" onclick="` + qv.onClickFn + `">Change</div>
                          </div>
                        </div>
                      </div>`;
            }
          } else {
            if (assoc_val.length == 2) {
              input2 = `<div class="` + alt_class + `">
                              <div class="pb-1 pt-1 ps-1 text-start">` + label_title + `</div>
                              <div class="row">
                                <div class="col-12">
                                  <div class="form-group bmd-form-group">
                                    <input type="text" aria-label="` + v + `" name="` + object + `[` + assoc_val[0] + `][` + assoc_val[1] + `]" class="form-control">
                                  </div>
                                </div>
                               
                              </div>
                            </div>`;
              if (qv.binary) {
                input2 = `<div class="` + alt_class + `">
                                        <div class="ps-1 py-2">` + label_title + `</div>
                                        <div class="col-sm-12">
                                          <div class="form-group bmd-form-group">
                                            <textarea rows=4 cols=12 aria-label="` + v + `"  name="` + object + `[` + assoc_val[0] + `][` + assoc_val[1] + `]" class="form-control"></textarea>
                                          </div>
                                        </div>
                                      </div>`;
              }
              if (qv.editor) {
                input2 = `<div class="` + alt_class + `">
                                        <div class="ps-1 py-2">` + label_title + `</div>
                                        <div class="col-sm-12">
                                          <div class="form-group bmd-form-group">
                                            <textarea id="editor1" rows=10 cols=12 aria-label="` + v + `"  name="` + object + `[` + assoc_val[0] + `][` + assoc_val[1] + `]" class="form-control"></textarea>
                                          </div>
                                        </div>
                                      </div>`;
              }
            }
            if (assoc_val.length == 3) {
              input2 = `<div class="` + alt_class + `">
                              <div class="pb-1 pt-1 ps-1 text-start">` + label_title + `</div>
                              <div class="row">
                                <div class="col-12">
                                  <div class="form-group bmd-form-group">
                                    <input type="text" aria-label="` + v + `" name="` + object + `[` + assoc_val[0] + `][` + assoc_val[1] + `][` + assoc_val[2] + `]" class="form-control">
                                  </div>
                                </div>
                               
                              </div>
                            </div>`;
            }
          }
        }
        if (qv.hidden) {
          if (v.includes(".")) {
            var assoc_val = v.split(".");
            input2 = '<input type="hidden" aria-label="' + v + '" name="' + object + "[" + assoc_val[0] + "][" + assoc_val[1] + ']"  aria-value="' + qv.data + '">';
          } else {
            console.log("qv", qv.data);
            input2 = '<input type="hidden" aria-label="' + v + '" name="' + object + "[" + v + ']"  aria-value="' + qv.data + '">';
          }
        }
        if (qv.required) {
          input2 = input2.replaceAll("input type", "input required type");
        }
      }
      return input2;
    },
    appendInputs(xv, cols, j, object) {
      $(cols).each(function(qi, qv) {
        var v;
        if (typeof qv == "object") {
          v = qv.label;
        } else {
          v = qv;
        }
        var input = "";
        var input2 = "";
        input2 = phxApp_.generateInputs(j, v, object, qv);
        if (typeof qv == "object") {
          var selections = [];
          if (qv.binary) {
          } else {
            if (qv.sub != null) {
              var subModule = qv.sub.moduleName;
              var subLink = qv.sub.link;
              var customCols = qv.sub.customCols;
              $.ajax({
                url: "/api/webhook?scope=gen_inputs",
                dataType: "json",
                async: false,
                data: {
                  module: subModule
                }
              }).done(function(j2) {
                var cols2 = Object.keys(j2);
                if (customCols != null) {
                  if (customCols.length > 0) {
                    cols2 = customCols;
                  }
                }
                var combo = [];
                $(cols2).each((i, col) => {
                  var v2;
                  if (typeof col == "object") {
                    v2 = col.label;
                  } else {
                    v2 = col;
                  }
                  var input3 = "";
                  input3 = phxApp_.generateInputs(j2, v2, subLink, col);
                  combo.push(input3);
                });
                input2 = input2 + `<div class="row subform" style="display: none;"><div class="offset-1 col-sm-9">` + combo.join("") + `</div></div>`;
              }).fail(function(e) {
                if (e.status == 403) {
                  memberApp_.logout();
                }
                phxApp_.notify("Not Added!", {
                  type: "danger"
                });
              });
            }
          }
        }
        $(xv).append(input2);
      });
    },
    form_new(id, data2, customCols, postFn, onDrawFn) {
      console.log(data2);
      var dataSource = window.phoenixModels.filter((v, i) => {
        return v.tableSelector == id;
      })[0];
      var default_selector = "#mySubModal";
      if (data2.modalSelector != null) {
        default_selector = data2.modalSelector;
      }
      if (customCols == null) {
        customCols = dataSource.customCols;
      }
      var form = `<form style="" class="with_mod" id="` + dataSource.link + `"  module="` + dataSource.moduleName + `">
      </form>`;
      $(default_selector).find(".modal-title").html("Create  New " + dataSource.moduleName);
      $(default_selector).find(".modal-body").html(form);
      phxApp_.createForm({
        ...{ id: 0 },
        ...data2
      }, dataSource.table, customCols, postFn, onDrawFn);
      $(default_selector).modal("show");
    },
    createForm(dtdata, table, customCols, postFn, onDrawFn) {
      $(".with_mod").each(function(i, xv) {
        $(xv).html(``);
        var mod = $(this).attr("module");
        var object = $(this).attr("id");
        $.ajax({
          async: false,
          url: "/api/webhook?scope=gen_inputs",
          dataType: "json",
          data: {
            module: mod
          }
        }).done(function(j) {
          var cols = Object.keys(j);
          if (customCols != null) {
            if (typeof customCols[0] === "object" && customCols[0] !== null) {
              console.log("has multi list," + customCols.length);
              $(xv).customHtml(`<input type="hidden" name="_csrf_token"  value="">
                            <div class="row">
                              <div class="col-12 col-lg-4">
                                <ul class="nav nav-pills flex-column form_nav">
                                 
                               
                                </ul>

                              </div>
                              <div class="col-12 col-lg-8 p-4 pt-lg-0 px-lg-4 " id="form_panels">

                              </div>
                            </div>

                        `);
              $(customCols).each((i2, v) => {
                if (i2 == 0) {
                  $(xv).find(".form_nav").customAppend(`
                                   <li class="nav-item">
                                      <a class="active nav-link fnc" aria-index="` + i2 + `" href="javascript:void(0);"  >` + v.name + `</a>
                                    </li>
                          `);
                } else {
                  $(xv).find(".form_nav").customAppend(`
                                   <li class="nav-item">
                                      <a class="nav-link fnc" aria-index="` + i2 + `" href="javascript:void(0);"  >` + v.name + `</a>
                                    </li>
                          `);
                }
                $(xv).find(".fnc").each((i3, v2) => {
                  v2.onclick = () => {
                    var index = $(v2).attr("aria-index");
                    $(".form_nav .nav-link").removeClass("active");
                    $(".nav-link[aria-index='" + index + "']").toggleClass("active");
                    $(".fp").addClass("d-none");
                    $("#panel_" + index).toggleClass("d-none");
                  };
                });
                if (i2 == 0) {
                  $(xv).find("#form_panels").customAppend(`<div class="fp row" id="panel_` + i2 + `"></div>`);
                } else {
                  $(xv).find("#form_panels").customAppend(`<div class="fp row d-none"  id="panel_` + i2 + `"></div>`);
                }
                $(xv).find("#panel_" + i2).customAppend(`<div class="col-lg-12"><b class="pb-4">` + v.name + `</b></div>`);
                phxApp_.appendInputs($(xv).find("#panel_" + i2), v.list, j, object);
              });
            } else {
              cols = customCols;
              $(xv).append(`<input type="hidden" name="_csrf_token"  value="">`);
              phxApp_.appendInputs(xv, cols, j, object);
              console.log(cols.join("','"));
            }
          } else {
            cols = cols.filter((v, i2) => {
              return v != "inserted_at";
            });
            cols = cols.filter((v, i2) => {
              return v != "updated_at";
            });
            phxApp_.appendInputs(xv, cols, j, object);
            console.log(cols.join("','"));
          }
          $($(xv).find("select")).on("change", function() {
            var val = $(this).val();
            var sf = $($(this).closest(".subform")).length;
            console.log(val);
            if (sf == 0) {
              if (val == 0) {
                $(".subform").fadeIn();
              } else {
                $(".subform").hide();
              }
            }
          });
          function btnSubm() {
            if ($("#myModal .modal-dialog").hasClass("modal-lg")) {
              $("#myModal .modal-dialog").toggleClass("modal-lg");
            }
            var formData = new FormData($(xv).closest("form")[0]);
            $(xv).find("input[type='checkbox']").each((zi, zv) => {
              $(zv).val($(zv).prop("checked"));
              formData.append(
                object + "[" + $(zv).attr("aria-label") + "]",
                $(zv).prop("checked")
              );
            });
            $(xv).find("textarea").each((zi, zv) => {
              formData.append(
                object + "[" + $(zv).attr("aria-label") + "]",
                $(zv).val()
              );
            });
            var failed_inputs = $(".with_mod").closest("form").find("input").filter((i2, v) => {
              console.log("checking vaidity");
              console.log(v);
              return v.checkValidity() == false;
            });
            console.log(failed_inputs);
            if (failed_inputs.length > 0) {
              failed_inputs.map((v, i2) => {
                phxApp_.notify("This input: " + $(i2).attr("placeholder") + " is not valid!", {
                  type: "danger"
                });
              });
            } else {
              var csrfToken = phxApp_.w(true);
              $.ajax({
                url: "/api/" + object,
                dataType: "json",
                headers: {
                  "Authorization": "Basic " + (phxApp_.user != null ? phxApp_.user.token : null),
                  "X-CSRF-Token": csrfToken
                },
                method: "POST",
                enctype: "multipart/form-data",
                processData: false,
                // tell jQuery not to process the data
                contentType: false,
                data: formData
              }).done(function(j2) {
                phxApp_.notify("Added!", {
                  type: "success"
                });
                $("#mySubModal").modal("hide");
                $("#sideModal").modal("hide");
                if (table != null) {
                  console.log("redrawing table.. " + window.currentSelector);
                  console.log(object);
                  console.log(window.currentSelector);
                  var tarMods = window.phoenixModels.filter((v, i2) => {
                    return v.moduleName == object && v.tableSelector == window.currentSelector;
                  });
                  tarMods.forEach((tarMod, i2) => {
                    try {
                      window.prev_page = tarMod.table.page();
                      tarMod.reload();
                    } catch (e) {
                      console.log("cant find the table");
                    }
                  });
                }
                if (postFn != null) {
                  if (dtdata.xparams != null) {
                    postFn(dtdata.xparams);
                  } else {
                    postFn(j2);
                  }
                }
              }).fail(function(e) {
                if (e.status == 403) {
                  memberApp_.logout();
                }
                try {
                  console.log(e.responseJSON.status);
                  phxApp_.notify("Not Added! reason: " + e.responseJSON.status, {
                    type: "danger"
                  });
                } catch (ee) {
                  phxApp_.notify("Not Added!", {
                    type: "danger"
                  });
                }
              });
            }
          }
          ;
          var row = document.createElement("div");
          row.className = "row";
          var col_lg_12 = document.createElement("div");
          col_lg_12.className = "pt-4 col-lg-12";
          row.append(col_lg_12);
          try {
            var ck_editor = CKEDITOR.replace("editor1", {
              height: 500,
              on: {
                instanceReady: function() {
                  this.document.appendStyleSheet("/css/bootstrap.min.css");
                }
              }
            });
            CKEDITOR.config.allowedContent = true;
            CKEDITOR.config.removeButtons = "Image";
            CKEDITOR.instances.editor1.on("change", function() {
              var data2 = CKEDITOR.instances.editor1.getData();
              $(CKEDITOR.instances.editor1.element["$"]).val(data2);
            });
            ck_editor.addCommand("mySimpleCommand", {
              exec: function(edt) {
                try {
                  callStoredMedia(CKEDITOR.instances.editor1);
                } catch (e) {
                }
              }
            });
            ck_editor.ui.addButton("SuperButton", {
              label: "Click me",
              command: "mySimpleCommand",
              toolbar: "insert",
              icon: "/images/image-solid.svg"
            });
          } catch (e) {
            console.log("no editor");
          }
          var submit_btn = phxApp_.formButton(
            {
              iconName: "check",
              color: "primary subm",
              name: "Submit"
            },
            {},
            btnSubm
          );
          col_lg_12.append(submit_btn);
          if ($(xv).find(".subm").length == 0) {
            $(xv).append(row);
          }
          console.info(dtdata);
          phxApp_.repopulateFormInput(dtdata, xv);
        }).fail(function(e) {
          if (e.status == 403) {
            memberApp_.logout();
          }
          console.log(e.responseJSON.status);
          phxApp_.notify("Not Added!", {
            type: "danger"
          });
        });
      });
      if (onDrawFn != null) {
        onDrawFn();
      }
    },
    submitFormData(selector, url, postFn, xparams) {
      if ($("#myModal .modal-dialog").hasClass("modal-lg")) {
        $("#myModal .modal-dialog").toggleClass("modal-lg");
      }
      var object = url;
      var xv = $(selector)[0];
      var formData = new FormData(xv);
      $(xv).find("input[type='checkbox']").each((zi, zv) => {
        $(zv).val($(zv).prop("checked"));
        formData.append(
          object + "[" + $(zv).attr("aria-label") + "]",
          $(zv).prop("checked")
        );
      });
      console.log(formData);
      $.ajax({
        url: "/api/" + object,
        dataType: "json",
        method: "POST",
        headers: {
          "Authorization": "Basic " + (phxApp_.user != null ? phxApp_.user.token : null)
        },
        enctype: "multipart/form-data",
        processData: false,
        // tell jQuery not to process the data
        contentType: false,
        data: formData,
        xhr: function() {
          $("#helper").fadeIn();
          var xhr = $.ajaxSettings.xhr();
          xhr.upload.onprogress = function(data2) {
            var perc2 = Math.round(data2.loaded / data2.total * 100);
            $("[role='progressbar']").css("width", perc2 + "%");
            $("#helper").text(perc2 + "%");
          };
          return xhr;
        },
        error: function(e) {
          console.error("Error has occurred while uploading the media file.");
        }
      }).done(function(j) {
        phxApp_.notify("Added!", {
          type: "success"
        });
        try {
          phxApp_.reinit();
          $("#myModal").modal("hide");
        } catch (e) {
        }
        try {
          if (postFn != null) {
            postFn(xparams);
          }
        } catch (e) {
        }
        phxApp_.hide();
      }).fail(function(e) {
        if (e.status == 403) {
          memberApp_.logout();
        }
        try {
          console.log(e.responseJSON.status);
          phxApp_.notify("Not Added! reason: " + e.responseJSON.status, {
            type: "danger"
          });
        } catch (ee) {
          phxApp_.notify("Not Added! reason: 404", {
            type: "danger"
          });
        }
      });
    },
    formButton(options, fnParams, onClickFunction) {
      var default_options = {
        iconName: "fa fa-check",
        color: "btn btn-primary",
        onClickFunction: null,
        fnParams: null,
        name: "Submit",
        tooltipText: "Hints"
      };
      var keys = Object.keys(default_options);
      keys.forEach((v, i2) => {
        this[v] = default_options[v];
      });
      keys.forEach((v, i2) => {
        if (options[v] != null) {
          this[v] = options[v];
        }
      });
      var button = document.createElement("button");
      button.setAttribute("type", "button");
      button.setAttribute("data-bs-toggle", "tooltip");
      button.setAttribute("data-bs-original-title", "");
      button.setAttribute("data-bs-placement", "left");
      button.setAttribute("class", "btn btn-" + this.color + " btn-sm");
      button.setAttribute("title", this.tooltipText);
      var i = document.createElement("i");
      i.className = this.iconName;
      button.append(i);
      var nameSpan = document.createElement("span");
      if (this.name == void 0) {
        this.name = "";
      } else {
        nameSpan.setAttribute("style", "padding: 0 10px;");
      }
      nameSpan.innerHTML = this.name;
      button.append(nameSpan);
      var div = document.createElement("div");
      div.className = "ripple-container";
      button.append(div);
      button.style = "margin-left: 10px;";
      if (onClickFunction != null) {
        try {
          button.id = this.fnParams.dtdata.id;
        } catch (e) {
          console.log("dont hav id in fnParams");
        }
        button.onclick = function() {
          if ($($(button).closest("tr")).attr("aria-index") == null) {
            fnParams.index = parseInt($($(button).closest("div")).attr("aria-index"));
          } else {
            fnParams.index = parseInt($($(button).closest("tr")).attr("aria-index"));
          }
          fnParams.row = $(button).closest("tr");
          fnParams.tbody = $(button).closest("tbody");
          onClickFunction(fnParams);
        };
      }
      return button;
    },
    groupedFormButton(name, color, button_list, fnParams) {
      var ref = phxApp_.makeid(6);
      var div = document.createElement("div");
      div.setAttribute("class", "btn-group");
      div.setAttribute("role", "group");
      div.setAttribute("aria-label", "Button group with nested dropdown");
      div.setAttribute("style", "margin-left: 10px;");
      var button = document.createElement("button");
      button.setAttribute("type", "button");
      button.setAttribute("class", "manage btn btn-sm btn-" + color);
      button.innerHTML = name;
      div.append(button);
      var div2 = document.createElement("div");
      div2.setAttribute("class", "btn-group");
      div2.setAttribute("role", "group");
      var button2 = document.createElement("button");
      button2.setAttribute("id", ref);
      button2.setAttribute("type", "button");
      button2.setAttribute("class", "btn btn-sm btn-" + color + " dropdown-toggle");
      button2.setAttribute("data-bs-toggle", "dropdown");
      button2.setAttribute("aria-haspopup", "true");
      button2.setAttribute("aria-expanded", "false");
      div2.append(button2);
      var div3 = document.createElement("div");
      div3.setAttribute("class", "dropdown-menu");
      div3.setAttribute("aria-labelledby", ref);
      $(button_list).each((i, v) => {
        if (v.fnParams != null) {
          v.fnParams.dataSource = fnParams.dataSource;
        } else {
          v.fnParams = fnParams;
        }
        var child = phxApp_.childGroupedFormButton(v.name, v.onClickFunction, v.fnParams);
        div3.append(child);
      });
      div2.append(div3);
      div.append(div2);
      return div;
    },
    childGroupedFormButton(name, onClickFunction, fnParams) {
      var button = document.createElement("a");
      button.setAttribute("class", "dropdown-item");
      button.setAttribute("href", "javascript:void(0);");
      button.innerHTML = name;
      if (onClickFunction != null) {
        try {
          button.id = fnParams.dtdata.id;
        } catch (e) {
        }
        button.onclick = function() {
          fnParams.index = parseInt($($(button).closest("tr")).attr("aria-index"));
          if (fnParams.index > -1) {
          } else {
            fnParams.index = parseInt($($(button).closest(".card-footer")).attr("aria-index"));
          }
          fnParams.row = $(button).closest("tr");
          onClickFunction(fnParams);
        };
      }
      return button;
    },
    makeid(length) {
      var result = "";
      var characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      var charactersLength = characters.length;
      for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
      }
      return result;
    },
    appendDtButtons(table_selector, parent_container_selector, data2) {
      $(table_selector).closest(parent_container_selector).find(".module_buttons").customHtml(`
                <button type="submit" onclick="toggleView('` + table_selector + `')" class="btn btn-fill btn-round btn-primary" data-href="" data-module="" data-ref="">
                <i class="fa fa-th-large"></i></button>
                <button type="submit" onclick="phxApp.reinit()" class="btn btn-fill btn-round btn-primary" data-href="" data-module="" data-ref="">
                <i class="fa fa-circle-notch
      "></i></button>
                <button type="submit" class="btn btn-fill btn-round btn-primary"  data-href="" data-module="add_new" data-ref=""><i class="fa fa-plus"></i></button>
                `);
      var nbutton = $(table_selector).closest(parent_container_selector).find(".module_buttons button[data-module='add_new']");
      try {
        nbutton[0].onclick = function() {
          window.currentSelector = table_selector;
          console.log("sub sub table data");
          console.log(data2);
          form_new(table_selector, data2);
        };
      } catch (e) {
      }
    },
    appendRowDtButtons(dataSource, index) {
      $(dataSource.buttons).each((i, params) => {
        if (params.buttonType != null) {
          if (params.buttonType == "grouped") {
            console.log("creating grouped...button...");
            params.fnParams.dataSource = dataSource;
            params.fnParams.aParams = dataSource.data;
            var buttonz = phxApp_.groupedFormButton(
              params.name,
              params.color,
              params.buttonList,
              params.fnParams
            );
            $(dataSource.tableSelector).closest(".table-responsive").find(".gd[aria-index='" + index + "']").removeClass("d-none");
            $(dataSource.tableSelector).closest(".table-responsive").find(".gd[aria-index='" + index + "']").append(buttonz);
          } else {
            params.fnParams.dataSource = dataSource;
            params.fnParams.aParams = dataSource.data;
            var buttonz = phxApp_.formButton(
              {
                iconName: params.iconName,
                color: params.color,
                name: params.name
              },
              params.fnParams,
              params.onClickFunction
            );
            $(dataSource.tableSelector).closest(".table-responsive").find(".gd[aria-index='" + index + "']").removeClass("d-none");
            $(dataSource.tableSelector).closest(".table-responsive").find(".gd[aria-index='" + index + "']").append(buttonz);
          }
        } else {
          console.log("appending gd buttons : " + i);
          params.fnParams.dataSource = dataSource;
          params.fnParams.aParams = dataSource.data;
          var buttonz = phxApp_.formButton(
            {
              iconName: params.iconName,
              color: params.color,
              name: params.name,
              tooltipText: params.tooltipText
            },
            params.fnParams,
            params.onClickFunction
          );
          $(dataSource.tableSelector).closest(".table-responsive").find(".gd[aria-index='" + index + "']").removeClass("d-none");
          $(dataSource.tableSelector).closest(".table-responsive").find(".gd[aria-index='" + index + "']").append(buttonz);
        }
      });
    },
    getTableData(dataSourcee, length, onCompleteFn) {
      var len = 100;
      if (length != null) {
        len = length;
      }
      var keys = Object.keys(dataSourcee.data);
      var xparams = [];
      $(keys).each((i, k) => {
        xparams.push("&" + k + "=" + dataSourcee.data[k]);
      });
      $.ajax({
        async: false,
        url: "/api/" + dataSourcee.link + "?foo=bar" + xparams.join(""),
        data: {
          draw: "1",
          order: {
            0: {
              column: "0",
              dir: "desc"
            }
          },
          columns: {
            0: {
              data: "id"
            }
          },
          length: len,
          start: 0
        }
      }).done(function(j) {
        $(j.data).each((i, dtdata) => {
          var added = $(dataSourcee.allData).filter(function(i2, v) {
            return v.id == dtdata.id;
          });
          if (added.length == 0) {
            dataSourcee.allData.push(dtdata);
          }
        });
        if (onCompleteFn != null) {
          onCompleteFn();
        }
      }).fail(function(e) {
        if (e.status == 403) {
          memberApp_.logout();
        }
        phxApp_.notify("Not Added!", {
          type: "danger"
        });
      });
    },
    copyToClipboard(text) {
      navigator.clipboard.writeText(text).then(() => {
        console.log("Text copied to clipboard:", text);
        alert("Text copied to clipboard!");
      }).catch((err) => {
        console.error("Could not copy text: ", err);
        alert("Could not copy text: " + err);
      });
    },
    populateTableData(dataSourcee, length, onCompleteFn) {
      this.getTableData(dataSourcee, length, onCompleteFn);
    },
    populateGridView(dataSource) {
      console.log(dataSource);
      var grid_class = "col-12 col-lg-3 xc";
      try {
        if (dataSource.data.grid_class != null) {
          grid_class = dataSource.data.grid_class + " xc";
        }
      } catch (e) {
      }
      $(dataSource.tableSelector).closest(".dataTables_wrapper").find(".grid_view").html("<div></div>");
      var alis = [];
      dataSource.table.data().length;
      for (i = 0, j = dataSource.table.data().length; i < j; i++) {
        dataSource.table.data()[i].index = i;
        alis.push(dataSource.table.data()[i]);
      }
      var i, j, chunk = 12;
      var temparray = [];
      for (i = 0, j = alis.length; i < j; i += chunk) {
        temparray.push(alis.slice(i, i + chunk));
      }
      temparray.forEach((row, i2) => {
        var parentDiv = document.createElement("div");
        parentDiv.setAttribute("class", "row gx-0 ");
        row.forEach((pv, pi) => {
          var data2 = pv;
          var div = document.createElement("div");
          div.setAttribute("class", grid_class);
          var card = document.createElement("div");
          card.setAttribute("id", data2.id);
          card.className = "card-footer gd d-none";
          div.data = pv;
          div.data.dataSource = dataSource;
          if (data2.index != null) {
            card.setAttribute("aria-index", data2.index);
          }
          ;
          div.appendChild(card);
          parentDiv.appendChild(div);
        });
        $(dataSource.tableSelector).closest(".dataTables_wrapper").find(".grid_view").append(parentDiv);
      });
      $(dataSource.tableSelector).closest(".table-responsive").find(" .gd").each((i2, v) => {
        var id = $(v).attr("aria-index");
        console.log("there is index... d" + i2);
        phxApp_.appendRowDtButtons(dataSource, id);
      });
    },
    populateTable(dataSource) {
      var custSorts = [
        [0, "desc"]
      ];
      var location2 = "/api/";
      if (dataSource.data.host != null) {
        location2 = dataSource.data.host + "/api/";
      }
      var custPageLength = 10;
      var custDom = `

    <"row align-items-center"
      <"col-lg-4"l>
      <"gap-2 col-lg-8 text-center 
        module_buttons 
        d-flex justify-content-lg-end 
        justify-content-center py-2 py-lg-0">
    >
    <"row grid_view d-block d-lg-none">
    <"list_view d-lg-block d-none"t>
    <"row transform-75 p-4"
      <"col-lg-6"i><"col-lg-6"p>
    >

    `;
      if (dataSource.data.dom != null) {
        custDom = dataSource.data.dom;
      }
      if (dataSource.data.sorts != null) {
        custSorts = dataSource.data.sorts;
      }
      if (dataSource.data.pageLength != null) {
        custPageLength = dataSource.data.pageLength;
      }
      var tr = document.createElement("tr");
      var ftr = document.createElement("tr");
      $(dataSource.columns).each(function(i, v) {
        var td = document.createElement("td");
        td.innerHTML = v.label;
        tr.append(td);
      });
      $(dataSource.columns).each(function(i, v) {
        var td = document.createElement("td");
        ftr.append(td);
      });
      console.info(custSorts);
      $(dataSource.tableSelector).find("thead").append(tr);
      $(dataSource.tableSelector).find("tfoot").html(ftr);
      console.log(dataSource.data);
      var keys = Object.keys(dataSource.data);
      var xparams = [];
      $(keys).each((i, k) => {
        if (!["modalSelector", "sorts", "dom", "footerFn", "rowFn", "preloads", "grid_class"].includes(k)) {
          xparams.push("&" + k + "=" + dataSource.data[k]);
        }
        if (["preloads"].includes(k)) {
          xparams.push("&" + k + "=" + JSON.stringify(dataSource.data[k]));
        }
        if (["additional_join_statements"].includes(k)) {
          xparams.push("&" + k + "=" + JSON.stringify(dataSource.data[k]));
        }
      });
      var table_selector = dataSource.tableSelector;
      var table = $(table_selector).DataTable({
        pageLength: custPageLength,
        processing: true,
        responsive: true,
        serverSide: true,
        ajax: {
          url: location2 + dataSource.link + "?foo=bar" + xparams.join("")
        },
        columns: dataSource.columns,
        lengthMenu: [8, 10, 12, 25, 50, 100],
        rowCallback: function(row, dtdata, index) {
          console.log("dt rowcallback index " + index);
          var added = $(dataSource.allData).filter(function(i, v) {
            return v.id == dtdata.id;
          });
          if (added.length == 0) {
            dataSource.allData.push(dtdata);
          }
          $(row).addClass("d-none");
          $(row).attr("aria-index", index);
          lastCol = $(row).find("td").length - 1;
          row.dataset.dtdata = JSON.stringify(dtdata);
          ColumnFormater.datetime(row, dtdata, dataSource);
          ColumnFormater.img(row, dtdata, dataSource);
          ColumnFormater.bool(row, dtdata, dataSource);
          ColumnFormater.float(row, dtdata, dataSource);
          ColumnFormater.child(row, dtdata, dataSource);
          ColumnFormater.json(row, dtdata, dataSource);
          ColumnFormater.subtitle(row, dtdata, dataSource);
          ColumnFormater.progress(row, dtdata, dataSource);
          ColumnFormater.custom(row, dtdata, dataSource);
          $("td:eq(" + lastCol + ")", row).attr("class", "td-actions text-end");
          $("td:eq(" + lastCol + ")", row).html("");
          $(dataSource.buttons).each((i, params) => {
            if (params.buttonType != null) {
              if (params.buttonType == "grouped") {
                console.log("creating grouped...button...");
                params.fnParams.dataSource = dataSource;
                params.fnParams.aParams = dataSource.data;
                var buttonz = phxApp_.groupedFormButton(
                  params.name,
                  params.color,
                  params.buttonList,
                  params.fnParams
                );
                $("td:eq(" + lastCol + ")", row).append(buttonz);
              } else {
                params.fnParams.dataSource = dataSource;
                params.fnParams.aParams = dataSource.data;
                var buttonz = phxApp_.formButton(
                  {
                    iconName: params.iconName,
                    color: params.color,
                    name: params.name
                  },
                  params.fnParams,
                  params.onClickFunction
                );
                $("td:eq(" + lastCol + ")", row).append(buttonz);
              }
            } else {
              params.fnParams.dataSource = dataSource;
              params.fnParams.aParams = dataSource.data;
              var buttonz = phxApp_.formButton(
                {
                  iconName: params.iconName,
                  color: params.color,
                  name: params.name,
                  tooltipText: params.tooltipText
                },
                params.fnParams,
                params.onClickFunction
              );
              $("td:eq(" + lastCol + ")", row).append(buttonz);
            }
          });
          if (dataSource.data.rowFn != null) {
            dataSource.data.rowFn(row, dtdata, index);
          }
        },
        footerCallback: function(row, data2, start, end, display) {
          if (dataSource.data != null) {
            if (dataSource.data.footerFn != null) {
              dataSource.data.footerFn(row, data2, start, end, display);
            }
          }
        },
        order: custSorts,
        dom: custDom,
        autoWidth: false
      });
      dataSource.table = table;
      table.on("preXhr", () => {
        console.log("fetching...");
      });
      table.on("draw", () => {
        $(".jsv" + dataSource.makeid.id).closest("tr").each((i, v) => {
          var j = dataSource.columns.filter((v2, i2) => {
            return v2.showJson == true;
          });
          j.forEach((xx, xi) => {
            $($(v).find(".jsv" + dataSource.makeid.id)[xi]).jsonViewer(table.data()[i][xx.data], { collapsed: true });
          });
        });
        $(".table tbody tr").each((i, v) => {
          setTimeout(() => {
            $(v).removeClass("d-none");
          }, 10 * i + 1);
        });
      });
      table.on("xhr", () => {
        console.log("fetched");
      });
      var delete_idx = window.phoenixModels.findIndex((v, i) => {
        return v.tableSelector == "#subSubTable";
      });
      if (delete_idx != -1) {
        window.phoenixModels.splice(delete_idx, 1);
      }
      var check2 = window.phoenixModels.filter((v, i) => {
        return v.moduleName == dataSource.moduleName && v.tableSelector == dataSource.tableSelector;
      });
      if (check2.length == 0) {
        window.phoenixModels.push(dataSource);
      } else {
        console.info("the dt already exist, consider reinsert?");
        var delete_idx = window.phoenixModels.findIndex((v, i) => {
          return v.moduleName == dataSource.moduleName && v.tableSelector == dataSource.tableSelector;
        });
        if (delete_idx != -1) {
          window.phoenixModels.splice(delete_idx, 1);
          window.phoenixModels.push(dataSource);
        }
      }
      return table;
    },
    editData(params) {
      console.log("editing data...");
      var dt = params.dataSource;
      window.currentSelector = dt.tableSelector;
      var table = dt.table;
      var r = table.row(params.row);
      var rowData = table.data()[params.index];
      var preferedLink;
      if (params.link != null) {
        preferedLink = params.link;
      } else {
        preferedLink = dt.link;
      }
      var default_selector = "#sideModal";
      if ($(default_selector).length == 0) {
        default_selector = "#mySubModal";
      }
      if (dt.data.modalSelector != null) {
        default_selector = dt.data.modalSelector;
      }
      function call() {
        console.log(rowData);
        var jj = `<form style="margin-top: 0px;" class="with_mod" id="` + preferedLink + `"  module="` + dt.moduleName + `"></form>`;
        $(default_selector).find(".modal-title").html("Edit " + dt.moduleName);
        $(default_selector).find(".modal-body").html(jj);
        $(default_selector).modal("show");
        phxApp_.createForm(rowData, table, params.customCols, params.postFn);
        if (params.drawFn != null) {
          params.drawFn();
        }
      }
      if (r.child.isShown()) {
        r.child.hide();
        call();
      } else {
        table.rows().every(function(rowIdx, tableLoop, rowLoop) {
          this.child.hide();
        });
        gParent = this;
        call();
      }
    },
    deleteData(params) {
      console.log("editing data...");
      var dt = params.dataSource;
      window.currentSelector = dt.tableSelector;
      var table = dt.table;
      var r = table.row(params.row);
      var rowData = table.data()[params.index];
      $("#myModal").find(".modal-title").html("Confirm delete this data?");
      var confirm_button = phxApp_.formButton("fa fa-check", "outline-danger");
      var csrfToken = this.w();
      confirm_button.onclick = function() {
        console.log(dt);
        $("#myModal").modal("hide");
        $.ajax({
          url: "/api/" + dt.link + "/" + rowData.id,
          dataType: "json",
          headers: {
            "Authorization": "Basic " + (phxApp_.user != null ? phxApp_.user.token : null),
            "x-csrf-token": csrfToken
          },
          method: "DELETE"
        }).done(function(j) {
          $("#myModal").modal("hide");
          phxApp_.notify("Deleted!", {
            type: "info"
          });
          if (table != null) {
            console.log("redrawing table.. " + window.currentSelector);
            console.log(dt.link);
            console.log(window.currentSelector);
            var tarMods = window.phoenixModels.filter((v, i) => {
              return v.moduleName == dt.link && v.tableSelector == window.currentSelector;
            });
            tarMods.forEach((tarMod, i) => {
              try {
                window.prev_page = tarMod.table.page();
                tarMod.reload();
              } catch (e) {
                console.log("cant find the table");
              }
            });
          }
        }).fail(function(e) {
          console.log(e.responseJSON.status);
          phxApp_.notify("Not Added! reason: " + e.responseJSON.status, {
            type: "warning"
          });
        });
      };
      var center = document.createElement("center");
      center.append(confirm_button);
      $("#myModal").find(".modal-body").html(center);
      $("#myModal").modal("show");
    }
  };

  // assets/js/member_app.js
  var memberApp_ = {
    user: {},
    ranks: [],
    restoreUser() {
      this.ranks = phxApp_.api("get_ranks", {});
      this.user = JSON.parse(localStorage.getItem("user"));
      if (this.user != null) {
        $("[aria-label='login']").addClass("d-none");
        $("[aria-label='logout']").removeClass("d-none");
      }
      if ($("form#register")) {
        if (this.user != null) {
          $("input[name='user[sales_person_id]']").val(this.user.id);
          $("input[name='user[username]']").val("");
        }
      }
    },
    override(j) {
      phxApp_.form($(j).closest("form"), "override", (j2) => {
        memberApp_.user = j2;
        memberApp_.save(j2);
        $("[aria-label='login']").addClass("d-none");
        $("[aria-label='logout']").removeClass("d-none");
        window.location = "/home";
      });
    },
    extendUser() {
      phxApp_.api("extend_user", { token: this.user.token }, null, (j) => {
        console.log(j);
        if (j.status == "ok") {
          memberApp_.user = j.res;
          memberApp_.save(j.res);
        }
      });
    },
    save(j) {
      localStorage.setItem("user", JSON.stringify(j));
    },
    merchantCheckout(dom) {
      $(dom).closest("form");
      if (phxApp_.e != null) {
        $("input[name='user[country_id]']").val(phxApp_.e.id);
      }
      phxApp_.validateForm("form", () => {
        console.info("validating form...");
        phxApp_.form($(dom).closest("form"), "merchant_checkout", (e) => {
          console.info("after redeem form...");
          console.log(e);
          if (e != null) {
            console.log("e user");
            console.log(e.user);
            commerceApp_.h(true);
            phxApp_.navigateTo(e.payment_url);
          } else {
            commerceApp_.h(true);
            phxApp_.navigateTo("/profile");
          }
        });
      });
    },
    redeem(dom) {
      $(dom).closest("form");
      if (phxApp_.e != null) {
        $("input[name='user[country_id]']").val(phxApp_.e.id);
      }
      phxApp_.validateForm("form", () => {
        console.info("validating form...");
        phxApp_.form($(dom).closest("form"), "redeem", (e) => {
          console.info("after redeem form...");
          console.log(e);
          if (e != null) {
            console.log("e user");
            console.log(e.user);
            commerceApp_.h();
            phxApp_.navigateTo(e.payment_url);
          } else {
            commerceApp_.h();
            phxApp_.navigateTo("/profile");
          }
        });
      });
    },
    upgrade(dom) {
      $(dom).closest("form");
      if ($("form#register")) {
        if (this.user != null) {
          $("input[name='user[sales_person_id]']").val(this.user.id);
        }
        if (phxApp_.e != null) {
          $("input[name='user[country_id]']").val(phxApp_.e.id);
        }
      }
      phxApp_.validateForm("form", () => {
        console.info("validating form...");
        phxApp_.form($(dom).closest("form"), "upgrade", (e) => {
          console.info("after upgrade form...");
          console.log(e);
          if (e != null) {
            if (e.billplz_code != null) {
              commerceApp_.h();
              window.location = e.payment_url;
            } else {
              if ($("input[name='user[instalment]']").val() == null) {
                phxApp_.notify("Please relogin to update rank.");
              }
              commerceApp_.h();
              commerceApp_.components["userProfile"]();
              phxApp_.navigateTo(e.payment_url);
            }
          } else {
            commerceApp_.h();
            phxApp_.navigateTo("/profile");
          }
        });
      });
    },
    linkRegister(dom) {
      if ($("form#register")) {
        if (this.user != null) {
          $("input[name='user[sales_person_id]']").val(this.user.id);
        }
        $("input[name='user[share_code]']").val(pageParams.share_code);
        if (phxApp_.e != null) {
          console.log(phxApp_.e);
          $("input[name='user[country_id]']").val(phxApp_.e.id);
        }
      }
      phxApp_.validateForm("form", () => {
        console.log("validating form...");
        phxApp_.form($(dom).closest("form"), "link_register", (j) => {
          console.log("after register form...");
          console.log(j);
          if (j != null) {
            commerceApp_.h();
            if (j.payment_method == "fpx") {
              let postRedirect = function(url, data2) {
                var form = $("<form>", {
                  "method": "POST",
                  "action": url
                });
                $.each(data2, function(key, value) {
                  $("<input>", {
                    "type": "hidden",
                    "name": key,
                    "value": value
                  }).appendTo(form);
                });
                form.appendTo("body").submit();
              };
              postRedirect(j.payment_url, JSON.parse(j.webhook_details));
            }
          } else {
            commerceApp_.h();
            phxApp_.navigateTo("/login");
          }
        });
      });
    },
    register(dom) {
      if ($("form#register")) {
        if (this.user != null) {
          $("input[name='user[sales_person_id]']").val(this.user.id);
        }
        if (phxApp_.e != null) {
          console.log(phxApp_.e);
          $("input[name='user[country_id]']").val(phxApp_.e.id);
        }
      }
      phxApp_.validateForm("form", () => {
        console.log("validating form...");
        phxApp_.form($(dom).closest("form"), "register", (e) => {
          console.log("after register form...");
          console.log(e);
          if (e != null) {
            commerceApp_.h();
            window.stockistTarget = null;
            if (e.billplz_code != null) {
              window.location = e.payment_url;
            } else {
              phxApp_.navigateTo(e.payment_url);
            }
          } else {
            commerceApp_.h();
            phxApp_.navigateTo("/register");
          }
        });
      });
    },
    logout() {
      console.log("logging out...");
      localStorage.removeItem("user");
      $("[aria-label='login']").removeClass("d-none");
      $("[aria-label='logout']").addClass("d-none");
      phxApp_.notify("Log out!");
      document.cookie = "_commerce_front_key=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
      setTimeout(() => {
        location = "/login";
      }, 1e3);
    },
    updateUser(user) {
      memberApp_.user = user;
      memberApp_.save(user);
    },
    login(dom) {
      $(dom).closest("form");
      phxApp_.form($(dom).closest("form"), "login", (j) => {
        memberApp_.user = j;
        memberApp_.save(j);
        $("[aria-label='login']").addClass("d-none");
        $("[aria-label='logout']").removeClass("d-none");
        phxApp_.navigateTo("/home");
      });
    }
  };

  // assets/js/phoenixModel.js
  var phoenixModel = class {
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
      };
      var keys = Object.keys(default_options);
      keys.forEach((v, i) => {
        this[v] = default_options[v];
      });
      keys.forEach((v, i) => {
        if (options[v] != null) {
          this[v] = options[v];
        }
      });
      var phxData = this.data;
      function loadDefaultGrid(object) {
        $(object.tableSelector).closest(".dataTables_wrapper").find(".grid_view .xc").each((ti, tv) => {
          var data2 = tv.data;
          console.log("xcard..");
          if (object.xcard != null) {
            var res = object.xcard(data2);
            $(tv).prepend(res);
          } else {
            var cols = [];
            object.columns.forEach((v, i) => {
              var col = `
              <div class="d-flex flex-column pb-2" role="grid_data" aria-label="` + v.label + `">
                <label class="fw-light font-sm text-secondary">` + v.label + `</label>
              ` + ColumnFormater.dataFormatter(data2, v) + `
              </div>`;
              cols.push(col);
            });
            var div = document.createElement("div");
            div.className = " card p-2";
            div.innerHTML = cols.join("");
            console.log("ts");
            console.log(div);
            $(tv).prepend(div);
          }
        });
      }
      this.load = function(makeid, dom) {
        if (makeid != null) {
          this.tableSelector = "#" + makeid;
          this.makeid = { id: makeid, dom };
          phxApp_.Page.createTable(makeid, dom);
        } else {
          phxApp_.Page.createTable(this.makeid.id, this.makeid.dom);
        }
        phxApp_.populateTable(this);
        this.table.on("draw", () => {
          var toggleView = `

                    <li>
                      <a class="dropdown-item" href="javascript:void(0);" onclick="toggleView('` + this.tableSelector + `')">
                        <i class="me-3 fa fa-th-large"></i>Grid View
                      </a>
                    </li>

        `;
          var dfault_btns = `
              <div class="d-flex align-items-center">
                      <div class="btn btn-sm btn-outline-primary me-3" href="javascript:void(0);" data-href="" data-module="add_new" data-ref="">
                        <i class="me-3 fa fa-plus"></i>New
                      </div>


                <div class="dropdown morphing scale-left ">
                  <a href="#" class="more-icon dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-h"></i></a>
                  <ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow border-0">

                    <li>
                      <a class="dropdown-item" href="javascript:void(0);" onclick="phxApp.reinit()">
                        <i class="me-3 fa fa-circle-notch"></i>Reload
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="javascript:void(0);" data-href="" data-module="add_new" data-ref="">
                        <i class="me-3 fa fa-arrow-right"></i>New
                      </a>
                    </li>
                  </ul>
                </div>
              </div>

                `;
          $(this.tableSelector).closest(".table-responsive").find(".module_buttons").html(dfault_btns);
          var nbutton = $(this.tableSelector).closest(".table-responsive").find(".module_buttons [data-module='add_new']");
          try {
            if (nbutton.length > 0) {
              var ts = this.tableSelector;
              nbutton[0].onclick = function() {
                window.currentSelector = ts;
                phxApp_.form_new(ts, phxData);
              };
            }
          } catch (e) {
          }
          this.tableButtons.forEach((b, i) => {
            var buttonz = new formButton(
              {
                iconName: b.iconName,
                color: b.color,
                name: b.name
              },
              b.fnParams,
              b.onClickFunction
            );
            $(this.tableSelector).closest(".table-responsive").find(".module_buttons").prepend(buttonz);
          });
          if (this.onDrawFn != null) {
            this.onDrawFn();
          }
          phxApp_.populateGridView(this);
          loadDefaultGrid(this);
        });
        this.table.on("page", () => {
          try {
            window.prev_page = this.table.page();
          } catch (e) {
          }
        });
      };
      this.reload = function() {
        var id = this.tableSelector.split("#")[1];
        var html2 = `
                <table class="table"  style="width: 100%;" id="` + id + `">
                    <thead></thead>
                    <tbody></tbody>
                </table>
          `;
        $(this.tableSelector).closest(".table-responsive").html(html2);
        console.log("reload dt");
        phxApp_.populateTable(this);
        try {
          this.table.on("draw", () => {
            var toggleView = `<li><a class="dropdown-item" href="javascript:void(0);" onclick="toggleView('` + this.tableSelector + `')">Grid View<i class="fa fa-th-large"></i></a></li>`;
            $(this.tableSelector).closest(".table-responsive").find(".module_buttons").html(`
        <div class="d-flex align-items-center">
                      <div class="btn btn-sm btn-outline-primary me-3" href="javascript:void(0);" data-href="" data-module="add_new" data-ref="">
                        <i class="me-3 fa fa-plus"></i>New
                      </div>

          <div class="dropdown morphing scale-left ">
             <a href="#" class="more-icon dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-h"></i></a>
              <ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow border-0">
                <li><a class="dropdown-item" href="javascript:void(0);" onclick="phxApp.reinit()">Reload<i class="fa fa-repeat"></i></a></li>
                <li><a class="dropdown-item" href="javascript:void(0);" data-href="" data-module="add_new" data-ref="">New<i class="fa fa-arrow-right"></i></a></li>
              </ul>
            </div>
        </div>

           `);
            var nbutton = $(this.tableSelector).closest(".table-responsive").find(".module_buttons [data-module='add_new']");
            try {
              console.log("dt table data");
              console.log(this.data);
              console.log(nbutton);
              if (nbutton.length > 0) {
                var ts = this.tableSelector;
                nbutton[0].onclick = function() {
                  window.currentSelector = ts;
                  phxApp.form_new(ts, phxData);
                };
              }
            } catch (e) {
            }
            this.tableButtons.forEach((b, i) => {
              var buttonz = new formButton(
                {
                  iconName: b.iconName,
                  color: b.color,
                  name: b.name
                },
                b.fnParams,
                b.onClickFunction
              );
              $(this.tableSelector).closest(".table-responsive").find(".module_buttons").prepend(buttonz);
            });
            if (this.onDrawFn != null) {
              this.onDrawFn();
            }
            phxApp_.populateGridView(this);
            loadDefaultGrid(this);
          });
          this.table.on("init", () => {
            try {
              this.table.page(prev_page).draw("page");
            } catch (e) {
            }
          });
          this.table.on("page", () => {
            try {
              window.prev_page = this.table.page();
            } catch (e) {
            }
          });
        } catch (e) {
          console.log(e);
        }
      };
    }
  };

  // assets/js/commerce_app.js
  var commerceApp_ = {
    f: [],
    g: [],
    region: "MY",
    selectedInstalment: null,
    h(is_merchant) {
      const cartKey = is_merchant ? "mcart" : "cart";
      const firstCartCountryIdKey = is_merchant ? "first_mcart_country_id" : "first_cart_country_id";
      if (is_merchant) {
        this.g = [];
      } else {
        this.f = [];
      }
      localStorage.setItem(cartKey, JSON.stringify([]));
      localStorage.removeItem(firstCartCountryIdKey);
      commerceApp_[firstCartCountryIdKey] = null;
    },
    restoreCart(is_merchant) {
      const cartKey = is_merchant ? "mcart" : "cart";
      const firstCartCountryIdKey = is_merchant ? "first_mcart_country_id" : "first_cart_country_id";
      const cartData = localStorage.getItem(cartKey);
      if (cartData != null) {
        if (is_merchant) {
          this.g = JSON.parse(cartData);
          commerceApp_.first_mcart_country_id = localStorage.getItem(firstCartCountryIdKey);
        } else {
          this.f = JSON.parse(cartData);
          commerceApp_.first_cart_country_id = localStorage.getItem(firstCartCountryIdKey);
        }
      }
    },
    filterItemsByName(itemName) {
      const cart = this.f;
      var res = cart.filter((v, i) => {
        return v.name.includes(itemName);
      });
      console.log(res);
      return res;
    },
    hasCartItems(is_merchant) {
      const cart = is_merchant ? this.g : this.f;
      return cart.length;
    },
    k(item, is_merchant) {
      console.info(item);
      const cart = is_merchant ? this.g : this.f;
      const index = cart.findIndex((cartItem) => cartItem.id === item.id);
      if (item.is_instalment) {
        if (item.payInstalment) {
        } else {
          instalment_name = item.name;
          product_instalment_id = item.id;
          item = item.first_payment_product;
          item.selectedInstalmentId = product_instalment_id;
          item.selectedInstalment = {
            id: product_instalment_id,
            name: instalment_name
          };
        }
      }
      if (index >= 0) {
        cart[index].qty += 1;
      } else {
        item.qty = 1;
        cart.unshift(item);
      }
      const cartKey = is_merchant ? "mcart" : "cart";
      localStorage.setItem(cartKey, JSON.stringify(cart));
    },
    z(id, is_merchant) {
      const cartKey = is_merchant ? "mcart" : "cart";
      const cart = is_merchant ? this.g : this.f;
      const index = cart.findIndex((cartItem) => cartItem.id == parseInt(id));
      if (index >= 0) {
        var foundItem = cart[index];
        phxApp_.notify("item " + foundItem.name + " added !", {
          delay: 2e3,
          type: "success",
          placement: {
            from: "top",
            align: "center"
          }
        });
        foundItem.qty += 1;
      } else {
      }
      localStorage.setItem(cartKey, JSON.stringify(cart));
    },
    v(id, is_merchant) {
      const cartKey = is_merchant ? "mcart" : "cart";
      const cart = is_merchant ? this.g : this.f;
      const index = cart.findIndex((cartItem) => cartItem.id == parseInt(id));
      if (index >= 0) {
        var foundItem = cart[index];
        phxApp_.notify("item " + foundItem.name + " deducted !", {
          delay: 2e3,
          type: "success",
          placement: {
            from: "top",
            align: "center"
          }
        });
        foundItem.qty -= 1;
        if (foundItem.qty == 0) {
          this.q(id, is_merchant);
        }
      } else {
      }
      localStorage.setItem(cartKey, JSON.stringify(cart));
    },
    q(id, is_merchant) {
      const cartKey = is_merchant ? "mcart" : "cart";
      const cart = is_merchant ? this.g : this.f;
      const index = cart.findIndex((cartItem) => cartItem.id == parseInt(id));
      var foundItem = cart[index];
      phxApp_.notify("item " + foundItem.name + " removed !", {
        delay: 2e3,
        type: "warning",
        placement: {
          from: "top",
          align: "center"
        }
      });
      var removed = cart.splice(index, 1);
      localStorage.setItem(cartKey, JSON.stringify(cart));
      if (commerceApp_.f.length == 0) {
        commerceApp_.first_cart_country_id = null;
      }
    },
    toastChanges() {
      if ($("input[name='user[share_code]']").length > 0) {
      } else {
        phxApp_.toast({
          content: `<div class=""><ul class="">` + $(".ac").html() + `</ul></div>`
        });
      }
    },
    A(is_merchant) {
      const cart = is_merchant ? this.g : this.f;
      var amount = this.cart.map((v, i) => {
        return v.price;
      }).reduce((a, b) => {
        return a + b;
      });
      return amount;
    },
    render() {
      var list = [
        "merchantProducts",
        "merchantproduct",
        "merchantProfile",
        "merchant",
        "recruit",
        "topup",
        "country",
        "light",
        "userProfile",
        "wallet",
        "announcement",
        "products",
        "product",
        "rewardList",
        "rewardSummary",
        "mcart",
        "cart",
        "cartItems",
        "salesItems",
        "upgradeTarget",
        "upgradeTargetMerchant",
        "sponsorTarget",
        "stockistTarget",
        "choosePayment"
      ];
      list.forEach((v, i) => {
        if ($(v).length > 0) {
          try {
            this.components[v]();
          } catch (e) {
            console.log(error);
          }
        }
      });
    },
    components: {
      merchantproduct() {
        $("merchantproduct").customHtml(`
          <div class="text-center mt-4">
            <div class="spinner-border loading2" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
          </div>
            
        <div class="loading2 d-none" id="mpcontent" />
        `);
        phxApp_.api("get_mproduct", {
          id: pageParams.id
        }, null, (data2) => {
          $("title").html(data2.name);
          function addToMCart() {
            var check2 = commerceApp_.g.filter((v, i) => {
              return v.merchant_id == data2.merchant_id;
            });
            if (check2.length > 0) {
              commerceApp_.k(data2, true);
              commerceApp_.components["updateMCart"]();
              phxApp_.notify("Added " + data2.name, {
                delay: 2e3,
                type: "success",
                placement: {
                  from: "top",
                  align: "center"
                }
              });
            } else {
              if (commerceApp_.g.length == 0) {
                commerceApp_.k(data2, true);
                commerceApp_.components["updateMCart"]();
                phxApp_.notify("Added " + data2.name, {
                  delay: 2e3,
                  type: "success",
                  placement: {
                    from: "top",
                    align: "center"
                  }
                });
              } else {
                alert("cant add due to different merchants, empty it first.");
              }
            }
          }
          $(".spinner-border.loading2").parent().remove();
          $(".loading2").removeClass("d-none");
          var img;
          if (data2.img_url != null) {
            try {
              img = data2.img_url;
            } catch (e) {
              img = "/images/placeholder.png";
            }
          }
          $("#mpcontent").customHtml(`

        <div class="d-flex flex-column justify-content-center align-items-center ">
          <h2 id="ptitle">
          </h2>
              <div  class="d-flex justify-content-center p-4 " 
                  style="
                    position: relative; 
                    width: 320px;
                    height: 340px;">
              <div class="rounded py-2" style="
                    height: 340px;
                    width: 88%;
                    filter: blur(4px);
                    position: absolute;
                    background-repeat: no-repeat;
                    background-position: center;
                    background-size: cover;
                    background-image: url('` + img + `');
                    top: 30px;
                    left: 20px;
                    ">
              </div>
              <div class="rounded py-2" style="
                    height: 340px;
                    width:  100%;
                    z-index: 1;
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover; 
                    background-image: url('` + img + `');
                    ">
              </div>
            </div>
          <div style="margin-top: 50px;">` + data2.description + `</div>
          <div class="font-sm fw-light text-secondary text-center "><span class="format-float">` + data2.retail_price + ` </span> RP</div>
          <div class="btn btn-outline-primary mt-4" mproduct-id="` + data2.id + `">Add</div>
        </div>

        `);
          $("#ptitle").html(
            data2.name
          );
          $("[mproduct-id='" + data2.id + "']")[0].onclick = addToMCart;
        });
      },
      merchantProducts() {
        let selectedCountry;
        function evalCt() {
          if (phxApp.user == null) {
            return "b.is_approved=true|b.country_id=" + phxApp_.e.id;
          } else {
            return "b.is_approved=true|b.country_id=" + phxApp.user.country_id;
          }
        }
        function evalCard(onclickAttr, img, merchant, data2, showBtn) {
          var card = `
                      <div  class="position-relative m-2 d-flex flex-column gap-2" ` + onclickAttr + `>
                        <div  class="d-flex justify-content-center mb-4 py-4 background-p" 
                              style="
                                cursor: pointer;   
                                position: relative; "
                               >
                          <div class="rounded py-2 background-p" style="
                            
                                width: 80%;
                                filter: blur(4px);
                                position: absolute;
                                background-repeat: no-repeat;
                                background-position: center;
                                background-size: cover;
                                background-image: url('` + img + `');
                                
                                ">
                          </div>
                          <div class="rounded py-2 foreground-p" style="
                               
                                width:  100%;
                                z-index: 1;
                                background-position: center;
                                background-repeat: no-repeat;
                                background-size: cover; 
                                background-image: url('` + img + `');
                                ">
                          </div>
                        </div>
                        <div class="d-flex position-absolute" style="left: 10px; top: 12px;z-index: 10;">
                          <div class="bg-primary badge">` + merchant.name + `</div>
                        </div>
                        <div class="d-flex flex-column justify-content-center gap-2 mt-4">
                          <div class="font-sm fw-bold text-center">` + data2.name + `</div>
                           <div class="d-flex flex-column justify-content-center ">
                              <div class="font-sm fw-light text-secondary text-center "><span class="format-float">` + data2.retail_price + `</span> RP</div>
                           </div>
                           ` + showBtn + `
                        </div>
                      </div>
                      `;
          return card;
        }
        function evalCountry2(countryName) {
          var prefix = "v2";
          if (countryName == "Thailand") {
            prefix = "th";
          }
          if (countryName == "Vietnam") {
            prefix = "vn";
          }
          if (countryName == "China") {
            prefix = "cn";
          }
          return prefix;
        }
        var countries = [];
        phxApp_.j.forEach((v, i) => {
          countries.push(`
                  <button type="button" aria-name="` + v.name + `" aria-country="` + v.id + `" class="btn btn-primary ">` + v.name + ` ` + (v.alias || "") + `</button>
                `);
        });
        if (phxApp_.e == null && pageParams.share_code == null) {
          phxApp_.modal({
            selector: "#mySubModal",
            content: `
                      <center>
                        <div class="btn-group-vertical">
                        ` + countries.join("") + `
                        </div>
                      </center>
                    `,
            header: "Choose region",
            autoClose: false
          });
          $("[aria-country]").unbind();
          $("[aria-country]").click(function() {
            var country_id = $(this).attr("aria-country"), name = $(this).attr("aria-name");
            phxApp_.e = country_id;
            phxApp_.notify("Chosen region: " + name);
            localStorage.setItem("region", name);
            setTimeout(() => {
              $("#chosen-region").html(name);
            }, 1e3);
            if (localStorage.region != null) {
              langPrefix = evalCountry2(name);
            }
            translationRes = phxApp_.api("translation", {
              lang: langPrefix
            });
            $("#mySubModal").modal("hide");
            commerceApp_.components["country"]();
            phxApp_.navigateTo("/home");
          });
        }
        if (pageParams.share_code != null) {
          phxApp_.api("get_share_link_by_code", {
            code: pageParams.share_code
          }, null, (sponsor) => {
            selectedCountry = phxApp_.j.filter((v, i) => {
              return v.id == sponsor["user"]["country_id"];
            })[0];
            console.info(selectedCountry);
            phxApp_.e = sponsor["user"]["country_id"];
            var country_id = sponsor["user"]["country_id"], name = selectedCountry.name;
            phxApp_.notify("Chosen region: " + selectedCountry.name);
            localStorage.setItem("region", selectedCountry.name);
            setTimeout(() => {
              $("#chosen-region").html(name);
            }, 1e3);
            if (localStorage.region != null) {
              langPrefix = evalCountry2(name);
            }
            translationRes = phxApp_.api("translation", {
              lang: langPrefix
            });
            commerceApp_.components["country"]();
            $(".sponsor-name").customHtml("_sponsor: " + sponsor["user"]["username"] + " _position: " + sponsor.position);
            $(".sponsor-bank").html(`

                              <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-bold">Bank Details</span>
                                <span class=" my-4 me-4 d-flex justify-content-end align-items-end gap-1 flex-column">
                                  <div>` + sponsor["user"]["bank_name"] + `</div>
                                  <div>` + sponsor["user"]["bank_account_holder"] + `</div>
                                  <div>` + sponsor["user"]["bank_account_no"] + `</div>
                                </span>
                              </div>

                                `);
          });
        }
        if (phxApp_.e != null) {
          let addToMCart = function(dom) {
            var id = $(dom).attr("mproduct-id");
            var zdata = phxApp_.api("get_mproduct", {
              id
            }, () => {
            }, (data2) => {
              var check2 = commerceApp_.g.filter((v, i) => {
                return v.merchant_id == data2.merchant_id;
              });
              if (check2.length > 0) {
                try {
                  commerceApp_.k(data2, true);
                  commerceApp_.components["updateMCart"]();
                  commerceApp_.components["cartItems"]();
                  phxApp_.notify("Added " + data2.name, {
                    delay: 2e3,
                    type: "success",
                    placement: {
                      from: "top",
                      align: "center"
                    }
                  });
                } catch (E) {
                  console.error(E);
                }
              } else {
                if (commerceApp_.g.length == 0) {
                  commerceApp_.k(data2, true);
                  commerceApp_.components["updateMCart"]();
                  commerceApp_.components["cartItems"]();
                  phxApp_.notify("Added " + data2.name, {
                    delay: 2e3,
                    type: "success",
                    placement: {
                      from: "top",
                      align: "center"
                    }
                  });
                } else {
                  alert("cant add due to different merchants, empty it first.");
                }
              }
            });
          };
          $("merchantProducts").each((i, products) => {
            $(products).customHtml(`
                    <div class="text-center mt-4">
                      <div class="spinner-border loading" role="status">
                        <span class="visually-hidden">Loading...</span>
                      </div>
                    </div>
                      

                    <div class="row gx-0 d-none loading">
                      <div class="col-12 col-lg-10 offset-lg-1">
                        <div id="mproduct_tab1"></div>
                      </div>
                    </div>
                  `).then(() => {
              var customCols = null, random_id = "mproducts", productSource = new phoenixModel({
                onDrawFn: () => {
                  $(".spinner-border.loading").parent().remove();
                  $(".loading").removeClass("d-none");
                  setTimeout(() => {
                    $("[mproduct-id]").each((i2, v) => {
                      v.onclick = () => {
                        addToMCart(v);
                      };
                    });
                    ColumnFormater.formatDate();
                  }, 1200);
                },
                xcard: (params) => {
                  var data2 = params, showBtn = "", img = "/images/placeholder.png", onclickAttr = `onclick="phxApp.navigateTo('/merchant_products/` + data2.id + `/` + data2.name + `')"`;
                  if ($(products).attr("direct") != null) {
                    onclickAttr = "";
                    showBtn = `<div class="btn btn-outline-primary mt-4" mproduct-id="` + data2.id + `">Add</div>`;
                  }
                  if (data2.img_url != null) {
                    try {
                      img = data2.img_url;
                    } catch (e) {
                      img = "/images/placeholder.png";
                    }
                  }
                  var merchant = data2.merchant;
                  return evalCard(onclickAttr, img, merchant, data2, showBtn);
                },
                data: {
                  sorts: [
                    [1, "asc"]
                  ],
                  additional_join_statements: [{
                    merchant: "merchant"
                  }],
                  additional_search_queries: [
                    evalCt()
                  ],
                  preloads: ["merchant"],
                  grid_class: "col-4 col-lg-3",
                  dom: `

                                                      <"row px-4"
                                                        <"col-lg-6 col-12"i>
                                                        <"col-12 col-lg-6">
                                                      >
                                                      <"row grid_view ">
                                                      <"list_view d-none"t>
                                                      <"row transform-75 px-4"
                                                        <"col-lg-6 col-12">
                                                        <"col-lg-6 col-12"p>
                                                      >

                                                  `
                },
                columns: [
                  {
                    label: "id",
                    data: "id"
                  },
                  // {
                  //   label: 'retail_price',
                  //   data: 'retail_price'
                  // },
                  {
                    label: "Action",
                    data: "id"
                  }
                ],
                moduleName: "MerchantProduct",
                link: "MerchantProduct",
                customCols,
                buttons: [],
                tableSelector: "#" + random_id
              });
              productSource.load(random_id, "#mproduct_tab1");
            });
          });
        }
      },
      merchantProfile() {
        $("merchantProfile").html(`
        <form class="with_mod row" module="Merchant" id="Merchant">
        </form>
        `);
        var merc = phxApp_.user.merchant;
        if (phxApp_.user.merchant == null) {
          merc = {
            id: "0",
            user_id: phxApp.user.id
          };
        }
        var merchant_categorySourcex = new phoenixModel({
          columns: [{
            label: "Action",
            data: "id"
          }],
          moduleName: "MerchantCategory",
          link: "MerchantCategory",
          buttons: [],
          tableSelector: "#bc2c"
        });
        var bcs = phxApp_.populateTableData(merchant_categorySourcex, 100, () => {
        });
        try {
          console.info(bcs.allData);
        } catch (e) {
          console.error(e);
        }
        phxApp.createForm(
          merc,
          null,
          [
            {
              name: "General",
              list: [
                "id",
                "user_id",
                "name",
                {
                  label: "merchant_category_id",
                  alt_name: "Business Category",
                  alt_class: "col-12",
                  selection: merchant_categorySourcex.allData
                },
                {
                  alt_name: "Merchant Logo",
                  label: "img_url",
                  upload: true
                },
                {
                  label: "description",
                  binary: true,
                  alt_class: "col-12"
                },
                {
                  label: "commission_perc",
                  alt_name: "Percentage Contribution",
                  selection: [{
                    id: 0.05,
                    name: "5%"
                  }, {
                    id: 0.1,
                    name: "10%"
                  }, {
                    id: 0.15,
                    name: "15%"
                  }, {
                    id: 0.2,
                    name: "20%"
                  }, {
                    id: 0.22,
                    name: "25%"
                  }, {
                    id: 0.3,
                    name: "30%"
                  }, {
                    id: 0.35,
                    name: "35%"
                  }, {
                    id: 0.4,
                    name: "40%"
                  }, {
                    id: 0.45,
                    name: "45%"
                  }, {
                    id: 0.5,
                    name: "50%"
                  }]
                }
              ]
            },
            {
              name: "CompanyDetails",
              list: [
                {
                  label: "company_address",
                  alt_name: "Address",
                  alt_class: "col-12",
                  binary: true
                },
                {
                  label: "company_email",
                  alt_name: "Email",
                  alt_class: "col-12"
                },
                {
                  label: "company_phone",
                  alt_name: "Phone",
                  alt_class: "col-12"
                },
                {
                  label: "company_reg_no",
                  alt_name: "Reg No",
                  alt_class: "col-12"
                },
                {
                  label: "company_ssm_image_url",
                  alt_name: "SSM Image",
                  alt_class: "col-12",
                  upload: true
                }
              ]
            },
            {
              name: "BankDetails",
              list: [
                {
                  label: "bank_name",
                  alt_name: "Bank Name",
                  alt_class: "col-12"
                },
                {
                  label: "bank_account_holder",
                  alt_name: "Bank Account Holder",
                  alt_class: "col-12"
                },
                {
                  label: "bank_account_no",
                  alt_name: "Account Number",
                  alt_class: "col-12"
                }
              ]
            }
          ],
          (j) => {
            console.info(j);
            memberApp_.extendUser();
            phxApp.navigateTo("/merchant_profile");
          }
        );
      },
      merchant() {
        var cta = ` <div class="btn btn-primary btn-lg merchant-apply mb-4 disabled">Apply</div>`;
        if (phxApp_.user.merchant != null) {
          if (phxApp_.user.merchant.is_approved == false) {
            cta = ` <div class="btn btn-primary btn-lg merchant-apply ">Pending Approval</div>`;
          } else {
            phxApp_.navigateTo("/merchant_profile");
          }
        }
        function agree() {
          console.log("agree");
          $(".merchant-apply ").toggleClass("disabled");
        }
        window.agree = agree;
        $("merchant").html(`
          <h2 class="mt-2">Merchant Application</h2> 
          <div class="px-4 m-4">
            Terms and condition
          </div>
          <center class="w-100 d-lg-none d-block">
            <iframe class="my-4" style="width:100%; height: 600px;"  src="https://docs.google.com/document/d/e/2PACX-1vShkzZ2LaszYkpcKw82giaYPqzRhB8odK54rkrJLwc6YMiUNp7HLaHYFTYN0hNPngJvJ_XR36_T8b5Z/pub?embedded=true"></iframe>
          </center>
          
          <center class="w-100 d-lg-block d-none">
            <iframe class="my-4" style="width: 60%; height: 600px;"  src="https://docs.google.com/document/d/e/2PACX-1vShkzZ2LaszYkpcKw82giaYPqzRhB8odK54rkrJLwc6YMiUNp7HLaHYFTYN0hNPngJvJ_XR36_T8b5Z/pub?embedded=true"></iframe>
          </center>
          <center>

          <div class="form-check m-4">
            <input class="form-check-input" onchange="agree()" type="checkbox" value="" id="flexCheckDefault">
            <label class="form-check-label" for="flexCheckDefault">
            I agree to above terms and condition
            </label>
          </div>

          </center>
          <div>
           ` + cta + `
          </div>

        `);
        $(".merchant-apply").on("click", () => {
          phxApp_.post("apply_merchant", {
            id: phxApp_.user.id
          }, null, () => {
            phxApp_.navigateTo("/merchant_profile");
          });
        });
      },
      recruit() {
        $("recruit").each((i, recruit) => {
          console.log(recruit);
          var v = $(recruit).attr("merchant");
          console.log(v == "");
          if (v == "") {
            $(recruit).customHtml(`

            <div class="">
                <label class="my-2">Position</label>
                <select class="form-control" name="mposition">
                  <option>left</option>
                  <option>right</option>
                </select>
                <div class="mt-4 btn btn-primary generate-mlink">Generate</div>
            </div>



            `);
          } else {
            $(recruit).customHtml(`

            <div class="">
                <label class="my-2">Position</label>
                <select class="form-control" name="position">
                  <option>left</option>
                  <option>right</option>
                </select>
                <div class="mt-4 btn btn-primary generate-link">Generate</div>
            </div>



            `);
          }
          $(".generate-mlink").click(() => {
            phxApp_.api("get_merchant_share_link", {
              username: phxApp_.user.username,
              position: $("select[name='mposition']").val()
            }, null, (code) => {
              phxApp_.modal({
                autoClose: false,
                header: "Share Link",
                selector: "#mySubModal",
                content: `

                  <label class="my-2">Generated</label>
                  <input class="form-control" name="link"></input>
                  <div class="mt-4 btn btn-primary copy-link">Copy</div>




                `
              });
              $("input[name='link']").val(code.link);
              $(".copy-link").click(() => {
                try {
                  navigator.clipboard.writeText(code.link);
                  console.log("Content copied to clipboard");
                  phxApp_.notify("Copied!");
                } catch (E) {
                  phxApp_.notify("Cant copy", {
                    type: "danger"
                  });
                }
              });
            });
          });
          $(".generate-link").click(() => {
            phxApp_.api("get_share_link", {
              username: phxApp_.user.username,
              position: $("select[name='position']").val()
            }, null, (code) => {
              phxApp_.modal({
                autoClose: false,
                header: "Share Link",
                selector: "#mySubModal",
                content: `

                  <label class="my-2">Generated</label>
                  <input class="form-control" name="link"></input>
                  <div class="mt-4 btn btn-primary copy-link">Copy</div>




                `
              });
              $("input[name='link']").val(code.link);
              $(".copy-link").click(() => {
                try {
                  navigator.clipboard.writeText(code.link);
                  console.log("Content copied to clipboard");
                  phxApp_.notify("Copied!");
                } catch (E) {
                  phxApp_.notify("Cant copy", {
                    type: "danger"
                  });
                }
              });
            });
          });
        });
      },
      choosePayment() {
        var razerList = phxApp.api("razer_list", {}), channels = Object.keys(razerList), sections = [];
        channels.forEach((channel, i) => {
          var subSections = [];
          razerList[channel].forEach((child, ii) => {
            var div = `

            <div class="py-1 col-6 col-lg-4 use-channel" aria-channel-label='` + child.channel_map.direct.request + `' >
              <img class="w-100 m-2 m-lg-0" src="` + child.logo_url_120x43 + `"></img>
            </div>
            `;
            if (child.currency.includes("MYR")) {
              if (child.status == 1) {
                if (child.channel_map.direct.request != "") {
                  subSections.push(div);
                }
              }
            }
          });
          sections.push(`

            <div class="row mt-2 pb-1 border-success border-bottom">
           
            ` + subSections.join("") + `
            </div>


            `);
        });
        $("choosePayment").html(`
          <div class="my-4 d-flex justify-content-between">
            <div  class="btn btn-primary" onclick="$('#myPaymentModal').modal('show')">
              Choose Payment
            </div>
            <div class="" id="chosen-payment">
            </div>
          </div>
          <div class="modal" id="myPaymentModal">
            <div class="modal-dialog modal-lg" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Choose Payment</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span>
                  </button>
                </div>
                <div class="modal-body">
               

                        <section class="ps-0 p-4 razer-display">
                          <h4>Pay with</h4>
                        ` + sections.join("") + `
                        </section>
               
                </div>
                <div class="modal-footer">
                </div>
              </div>
            </div>
          </div>
        `);
        $(".use-channel").click(function() {
          var channel = $(this).attr("aria-channel-label");
          $(".use-channel").removeClass("border border-primary rounded");
          $(this).addClass("border border-primary rounded");
          console.info("use channel: " + channel);
          $("input[name='user[payment][channel]']").val(channel);
          var p2 = $(this).html();
          $("#chosen-payment").html(p2);
          $("#myPaymentModal").modal("hide");
        });
      },
      topup() {
        function payData(params) {
          var rowData = phxApp.rowData(params);
          console.log(rowData);
          if (rowData.payment != null) {
            if (rowData.payment.payment_method == "fpx") {
              msg = "";
              if (rowData.is_approved == false) {
                msg = `<p>You will be redirected to pay this topup.</p>
              <a target="_blank" href="` + rowData.payment.payment_url + `" class="btn btn-primary">Pay
              </a>`;
              }
              phxApp.modal({
                autoClose: false,
                selector: "#mySubModal",
                header: "FPX",
                content: `

              ` + msg + `
              <div class="btn btn-primary check">Recheck
              </div>

              `
              });
              $(".check").click(() => {
                phxApp.api("check_bill", {
                  id: rowData.payment.billplz_code
                });
              });
            } else {
              phxApp.modal({
                selector: "#mySubModal",
                header: "Details",
                content: `

            <div class="btn btn-primary delete">Delete Request
              </div>


              `
              });
            }
          } else {
            phxApp.modal({
              selector: "#mySubModal",
              header: "Details",
              content: `

              <p>` + rowData.remarks + `</p>

              `
            });
          }
          $(".delete").unbind();
          $(".delete").click(() => {
            phxApp.api("delete_topup_request", {
              id: rowData.id
            }, null, (r) => {
              $("#mySubModal").modal("hide");
              if (r.status == "error") {
                if (r.reason != "") {
                  phxApp.notify("Not Deleted! Reason: " + r.reason, {
                    type: "danger"
                  });
                }
              } else {
                phxApp.notify("Deleted!");
                phxApp.navigateTo("/topup_register_point");
              }
            });
          });
        }
        $("topup").customHtml(`    
        <div class="card-body ">
          <div class="d-flex justify-content-between align-items-center mb-4">
            <h3>Topup Transaction</h3>
            <div class="btn btn-primary " id="new_topup">
              <span class="d-flex align-items-center"><i class="fa fa-plus me-1"></i>Topup</span></div>
          </div>
          <div class="" id="tab2"></div>
        </div>
          `);
        window.selectedBank = (bank) => {
          var valu = $("input[name='WalletTopup[bank]']").val(bank);
        };
        var razerList = phxApp.api("razer_list", {}), channels = Object.keys(razerList), sections = [];
        channels.forEach((channel, i) => {
          var subSections = [];
          razerList[channel].forEach((child, ii) => {
            var div = `

            <div class="py-1 col-6 col-lg-4 use-channel" aria-channel-label='` + child.channel_map.direct.request + `' >
              <img class="w-100 m-2 m-lg-0" src="` + child.logo_url_120x43 + `"></img>
            </div>
            `;
            if (child.currency.includes("MYR")) {
              if (child.status == 1) {
                if (child.channel_map.direct.request != "") {
                  subSections.push(div);
                }
              }
            }
          });
          sections.push(`

            <div class="row mt-2 pb-1 border-success border-bottom">
           
            ` + subSections.join("") + `
            </div>


            `);
        });
        $("#new_topup").click(() => {
          phxApp.modal({
            selector: "#mySubModal",
            autoClose: false,
            header: "New Register Point Topup",
            content: `
            <div class="row ">
              <form class="col-12 offset-lg-1 col-lg-10 with_mod row p-4" module="WalletTopup" id="WalletTopup">
               

              </form>

            </div>
        `
          });
          phxApp.createForm(
            {
              id: "0",
              user_id: phxApp.user.id
            },
            null,
            [
              "id",
              {
                label: "amount",
                alt_name: "Amount (RP)",
                alt_class: "col-12"
              },
              {
                label: "remarks",
                alt_name: "Description",
                alt_class: "col-12"
              },
              {
                label: "payment-placeholder",
                alt_name: "Choose Payment",
                alt_class: "col-12",
                placeholder: `


                <div id="payment-placeholder">
                  <section class="p-4 razer-display">
                    <h3>Choose 1 channel</h3>
                  ` + sections.join("") + `
                  </section>
                  <section class="d-none upload-display">
                    <div class="px-4 pt-4">
                      Kindly bank in to either 1 of these account.
                    </div>
                    <div class="p-4 fs-5">
                      HAHO LIFE SDN. BHD.<br>
                      <span>
                        <div> MBB </div>
                        <div>5642 4949 7131  <div class="btn btn-primary" onclick="phxApp.copyToClipboard('564249497131');selectedBank('MBB')">Copy</div></div>
                      </span><br>
                      <span>
                        <div> CIMB </div>
                        <div>8011 2277 45 <div class="btn btn-primary" onclick="phxApp.copyToClipboard('8011227745');selectedBank('CIMB')">Copy</div></div>
                      </span><br>
                      <span>
                        <div> PUBLIC BANK </div>
                        <div>3237 7779 07 <div class="btn btn-primary" onclick="phxApp.copyToClipboard('3237777907');selectedBank('PBB')">Copy</div></div>
                      </span><br>
                    </div>
                  </section>
                  <div class="btn-group" role="group" aria-label="PaymentGroup">
                    <input type="radio" class="btn-check show-upload" name="btnradio" id="btnradio1z" autocomplete="off" >
                    <label class="btn btn-outline-primary" for="btnradio1z">Upload Bank In Slip</label>

                    <input type="radio" class="btn-check show-razer" name="btnradio" id="btnradio2z" autocomplete="off" checked="">
                    <label class="btn btn-outline-primary" for="btnradio2z">Online Banking/CC</label>
         
                  </div>

                </div>

            `
              },
              {
                label: "payment_method",
                selection: [{
                  id: "fpx",
                  name: "FPX"
                }, {
                  id: "bank in slip",
                  name: "BANK IN SLIP"
                }],
                alt_class: "d-none"
              },
              {
                label: "img_url",
                upload: true,
                alt_class: "d-none upload-display"
              },
              {
                label: "bank",
                data: "bank",
                hidden: true
              },
              "user_id"
            ],
            (j) => {
              console.info(j);
              if (j.payment_method == "fpx") {
                let postRedirect = function(url, data2) {
                  var form = $("<form>", {
                    "method": "POST",
                    "action": url
                  });
                  $.each(data2, function(key, value) {
                    $("<input>", {
                      "type": "hidden",
                      "name": key,
                      "value": value
                    }).appendTo(form);
                  });
                  form.appendTo("body").submit();
                };
                postRedirect(j.payment.payment_url, JSON.parse(j.payment.webhook_details));
              } else {
                phxApp.navigateTo("/topup_register_point");
              }
            }
          );
          $(".show-upload").click(() => {
            $(".upload-display").removeClass("d-none");
            $(".razer-display").addClass("d-none");
            $("select[name='WalletTopup[payment_method]']").val("bank in slip");
          });
          $(".show-razer").click(() => {
            $(".upload-display").addClass("d-none");
            $(".razer-display").removeClass("d-none");
            $("select[name='WalletTopup[payment_method]']").val("fpx");
          });
          $("input[name='WalletTopup[amount]']").on("change", () => {
            var valu = $("input[name='WalletTopup[amount]']").val();
            $("input[name='WalletTopup[remarks]']").val("MYR " + valu * 5);
          });
          $(".use-channel").click(function() {
            var channel = $(this).attr("aria-channel-label");
            $(".use-channel").removeClass("border border-primary rounded");
            $(this).addClass("border border-primary rounded");
            console.info("use channel: " + channel);
            $("input[name='WalletTopup[bank]']").val(channel);
          });
        });
        var customCols = null;
        var random_id = phxApp.makeid(4);
        wallet_topupSource = new phoenixModel({
          onDrawFn: () => {
            setTimeout(() => {
              phxApp.formatDate();
            }, 200);
          },
          xcard: (params) => {
            console.log(params);
            var data2 = params;
            var font_class = "text-success";
            if (data2.amount < 0) {
              font_class = "text-danger";
            }
            var status = `<span class="badge bg-warning">PENDING</span>`;
            if (data2.is_approved) {
              status = `<span class="badge bg-success">APPROVED</span>`;
            }
            var card = `
         

          <div class="row border-1 border-top py-2">
            <div class="col-6 text-start text-sm">` + status + `</div>
           <div class="col-6 text-end text-sm">Amount (RP)</div>
          </div>
          <div class="row">
            <div class="col-6 text-start text-sm format_datetime">` + data2.inserted_at + `</div>
       
           <div class="col-6 text-end "> <span class='format-integer'>` + data2.amount + `</span></div>
          </div>

          `;
            return card;
          },
          data: {
            grid_class: "col-12 ",
            dom: `
         <"row px-4 px-lg-0" 
          <"col-12 col-lg-6 "l>
          <"col-12 col-lg-6 text-lg-end "i>
        >
        <"row grid_view d-block d-lg-none">
        <"list_view d-none d-lg-block"t>
        <"row transform-75 px-4"
            <"col-lg-6 col-12">
            <"col-lg-6 col-12"p>
          >
      `,
            preloads: ["user", "payment"],
            additional_join_statements: [{
              user: "user"
            }],
            additional_search_queries: [
              "a.user_id=" + phxApp.user.id
            ]
          },
          columns: [
            {
              label: "id",
              data: "id"
            },
            {
              label: "Date",
              data: "inserted_at",
              formatDateTime: true,
              offset: 0
            },
            {
              customized: true,
              label: "Approved?",
              data: "is_approved",
              xdata: {
                formatFn: (d, index) => {
                  if (d.is_approved) {
                    html = `<div  ><i class="fa fa-check text-success"></i><span  class="ms-2">Approved</span></div>`;
                  } else {
                    html = `<div  ><i class="fa fa-hourglass text-warning"></i><span class="ms-2">Pending</span></div>`;
                  }
                  return html;
                }
              }
            },
            {
              label: "Payment",
              data: "id",
              showChild: true,
              xdata: {
                child: "payment",
                data: "payment_method"
              }
            },
            {
              label: "Amount",
              data: "amount",
              className: "format-float"
            },
            {
              label: "Action",
              data: "id",
              className: ""
            }
          ],
          moduleName: "WalletTopup",
          link: "WalletTopup",
          customCols,
          buttons: [{
            name: "Details",
            iconName: "fa fa-info",
            color: "btn-sm btn-outline-warning",
            onClickFunction: payData,
            fnParams: {}
          }],
          tableSelector: "#" + random_id
        });
        wallet_topupSource.load(random_id, "#tab2");
      },
      country() {
        if (localStorage.getItem("region") != null) {
          var sel = phxApp_.j.filter((v, i) => {
            return v.name == localStorage.getItem("region");
          })[0];
          phxApp_.e = sel;
          $("country").customHtml(`


        <li class="nav-item">
          <a class="nav-link choose-region" href="javascript:void(0);" > <i class="fa fa-globe"></i>` + localStorage.getItem("region") + `</a>
        </li>

      `);
        } else {
          $("country").customHtml(`


        <li class="nav-item">
          <a class="nav-link choose-region" href="javascript:void(0);" > <i class="fa fa-globe"></i> MY</a>
        </li>

      `);
        }
        var countries = [];
        phxApp_.j.forEach((v, i) => {
          countries.push(`
            <button type="button" aria-name="` + v.name + `" aria-country="` + v.id + `" class="btn btn-primary ">` + v.name + `</button>
          `);
        });
        $(".choose-region").click(() => {
          commerceApp_.h();
          phxApp_.modal({
            selector: "#mySubModal",
            content: `
          <center>
            <div class="btn-group-vertical">
            ` + countries.join("") + `
            </div>
          </center>
        `,
            header: "Choose region",
            autoClose: false
          });
          $("[aria-country]").unbind();
          $("[aria-country]").click(function() {
            var country_id = $(this).attr("aria-country"), name = $(this).attr("aria-name");
            phxApp_.e = country_id;
            phxApp_.notify("Chosen region: " + name);
            localStorage.setItem("region", name);
            setTimeout(() => {
              $("#chosen-region").html(name);
            }, 1e3);
            $("#mySubModal").modal("hide");
            try {
              let evalCountry2 = function(countryName) {
                var prefix = "v2";
                if (countryName == "Thailand") {
                  prefix = "th";
                }
                if (countryName == "Vietnam") {
                  prefix = "vn";
                }
                if (countryName == "China") {
                  prefix = "cn";
                }
                return prefix;
              };
              var langPrefix3 = "v2";
              if (localStorage.region != null) {
                langPrefix3 = evalCountry2(localStorage.region);
              }
              translationRes = phxApp_.api("translation", {
                lang: langPrefix3
              });
            } catch (error2) {
              console.error("Error fetching translation:", error2);
            }
            commerceApp_.components["country"]();
            commerceApp_.components["products"]();
            if ($("[name='user[pick_up_point_id]']").length > 0) {
              commerceApp_.components["cartItems"]();
            }
          });
        });
      },
      upgradeTarget() {
        var needInstalment = false, freebie = null, instalmentProduct;
        if ($("upgradeTarget").attr("instalment") != null) {
          console.log("ok");
          needInstalment = true;
          commerceApp_.h();
        }
        window.upgradeTarget;
        if (window.upgradeTarget == null) {
          window.upgradeTarget = memberApp_.user.username;
          $("input[name='user[upgrade]']").val(window.upgradeTarget);
        } else {
          $("input[name='user[upgrade]']").val(window.upgradeTarget);
        }
        $("upgradeTarget").customHtml(`<span>for: <span id="upgradeTarget">` + window.upgradeTarget + `</span> <a class="ms-4" href="javascript:void(0);" aria-upgrade=true> <i class="fa fa-edit"></i> Change</a> </span>`);
        $("[aria-upgrade]").click(() => {
          phxApp_.modal({
            selector: "#mySubModal",
            autoClose: false,
            content: `
          <div>
            <div class="form-group">
              <label>Username</label>
              <input class="my-2 form-control" type="text" name='upgrade[username]'></input>
                <div class="form-text text-muted pv-info"></div>

              <button class="mt-4 btn btn-outline-primary checkUser">Check</button>
              <button class="mt-4 btn btn-primary disabled selectUser">Select this user</button>
            </div>
          </div>
          `,
            header: "Change Upgrade User"
          });
          $(".checkUser").click(() => {
            phxApp_.api(
              "get_accumulated_sales",
              {
                show_instalment: true,
                parent_id: memberApp_.user.id,
                show_rank: true,
                username: $("[name='upgrade[username]']").val()
              },
              () => {
                window.upgradeTarget = memberApp_.user.username;
                $("input[name='user[upgrade]']").val(window.upgradeTarget);
                $(".selectUser").addClass("disabled");
              },
              (res) => {
                phxApp_.notify("User verified!");
                $(".selectUser").removeClass("disabled");
                $(".pv-info").customHtml(`Accumulated sales PV: ` + res[0] + ` | Rank: ` + res[1]);
                if (res[2].is_direct_downline) {
                  $(".to-upgrade").removeClass("disabled");
                } else {
                  phxApp_.notify("User not direct downline!", {
                    type: "warning"
                  });
                  $("label[for='btnradio3']").click();
                  $(".to-upgrade").addClass("disabled");
                  if (res[4].outstanding_instalments != null) {
                    if (res[4].outstanding_instalments.product.can_pay_by_drp) {
                      $(".to-upgrade").removeClass("disabled");
                    }
                  } else {
                  }
                }
                console.info(res[4].outstanding_instalments);
                try {
                  if (res[4].outstanding_instalments != null) {
                    $("input[name='user[shipping][fullname]']").val(res[4].outstanding_instalments.user.fullname);
                    $("input[name='user[shipping][phone]']").val(res[4].outstanding_instalments.user.phone);
                    $("input[name='user[instalment]']").val("Month no: " + res[4].outstanding_instalments.month_no + "/" + res[4].outstanding_instalments.instalment.no_of_months);
                    instalmentProduct = res[4].outstanding_instalments.product;
                    freebie = res[4].outstanding_instalments.member_instalment_product.product;
                  }
                } catch (e) {
                  console.error(e);
                }
              }
            );
          });
          $(".selectUser").click(() => {
            $("input[name='user[upgrade]']").val($("[name='upgrade[username]']").val());
            phxApp_.notify("User selected!");
            $("#mySubModal").modal("hide");
            window.upgradeTarget = $("[name='upgrade[username]']").val();
            $("#upgradeTarget").html($("[name='upgrade[username]']").val());
            if (instalmentProduct != null) {
              phxApp_.addItem(instalmentProduct.id);
              if (freebie != null) {
                phxApp_.addItem(freebie.id);
              }
            }
            commerceApp_.components["cartItems"]();
            console.info("need to check if member is direct sponsor");
          });
        });
      },
      upgradeTargetMerchant() {
        var needInstalment = false, freebie = null, instalmentProduct;
        if ($("upgradeTarget").attr("instalment") != null) {
          console.log("ok");
          needInstalment = true;
          commerceApp_.h();
        }
        window.upgradeTarget;
        if (window.upgradeTarget == null) {
          window.upgradeTarget = memberApp_.user.username;
          $("input[name='user[upgrade]']").val(window.upgradeTarget);
        } else {
          $("input[name='user[upgrade]']").val(window.upgradeTarget);
        }
        $("upgradeTargetMerchant").customHtml(`<span>for: <span id="upgradeTarget">` + window.upgradeTarget + `</span> <a class="ms-4" href="javascript:void(0);" aria-upgrade=true> <i class="fa fa-edit"></i> Change</a> </span>`);
        $("[aria-upgrade]").click(() => {
          phxApp_.modal({
            selector: "#mySubModal",
            autoClose: false,
            content: `
          <div>
            <div class="form-group">
              <label>Username</label>
              <input class="my-2 form-control" type="text" name='upgrade[username]'></input>
                <div class="form-text text-muted pv-info"></div>

              <button class="mt-4 btn btn-outline-primary checkUser">Check</button>
              <button class="mt-4 btn btn-primary disabled selectUser">Select this user</button>
            </div>
          </div>
          `,
            header: "Change Upgrade User"
          });
          $(".checkUser").click(() => {
            phxApp_.api(
              "get_accumulated_sales_merchant",
              {
                show_instalment: true,
                parent_id: memberApp_.user.id,
                show_rank: true,
                username: $("[name='upgrade[username]']").val()
              },
              () => {
                window.upgradeTarget = memberApp_.user.username;
                $("input[name='user[upgrade]']").val(window.upgradeTarget);
                $(".selectUser").addClass("disabled");
              },
              (res) => {
                phxApp_.notify("User verified!");
                $(".selectUser").removeClass("disabled");
                $(".pv-info").customHtml(`Accumulated sales PV: ` + res[0] + ` | Rank: ` + res[1]);
                if (res[2].is_direct_downline) {
                  $(".to-upgrade").removeClass("disabled");
                } else {
                  phxApp_.notify("User not direct downline!", {
                    type: "warning"
                  });
                  $("label[for='btnradio3']").click();
                  $(".to-upgrade").addClass("disabled");
                  if (res[4].outstanding_instalments != null) {
                    if (res[4].outstanding_instalments.product.can_pay_by_drp) {
                      $(".to-upgrade").removeClass("disabled");
                    }
                  } else {
                  }
                }
                console.info(res[4].outstanding_instalments);
                try {
                  if (res[4].outstanding_instalments != null) {
                    $("input[name='user[shipping][fullname]']").val(res[4].outstanding_instalments.user.fullname);
                    $("input[name='user[shipping][phone]']").val(res[4].outstanding_instalments.user.phone);
                    $("input[name='user[instalment]']").val("Month no: " + res[4].outstanding_instalments.month_no + "/" + res[4].outstanding_instalments.instalment.no_of_months);
                    instalmentProduct = res[4].outstanding_instalments.product;
                    freebie = res[4].outstanding_instalments.member_instalment_product.product;
                  }
                } catch (e) {
                  console.error(e);
                }
              }
            );
          });
          $(".selectUser").click(() => {
            $("input[name='user[upgrade]']").val($("[name='upgrade[username]']").val());
            phxApp_.notify("User selected!");
            $("#mySubModal").modal("hide");
            window.upgradeTarget = $("[name='upgrade[username]']").val();
            $("#upgradeTarget").html($("[name='upgrade[username]']").val());
            if (instalmentProduct != null) {
              phxApp_.addItem(instalmentProduct.id);
              if (freebie != null) {
                phxApp_.addItem(freebie.id);
              }
            }
            commerceApp_.components["cartItems"]();
            console.info("need to check if member is direct sponsor");
          });
        });
      },
      sponsorTarget() {
        window.sponsorTarget;
        if (window.sponsorTarget == null) {
          window.sponsorTarget = memberApp_.user.username;
        } else {
        }
        $("input[name='user[sponsor]']").val("");
        $("sponsorTarget").customHtml(`<span>for: <span id="sponsorTarget">` + window.sponsorTarget + `</span>
       <a class="ms-4" href="javascript:void(0);" aria-sponsor=true> <i class="fa fa-edit"></i> Change</a> </span>`);
        $("[aria-sponsor]").click(() => {
          phxApp_.modal({
            selector: "#mySubModal",
            autoClose: false,
            content: `
          <div>
            <div class="form-group">
              <label>Username</label>
              <input class="my-2 form-control" value="` + memberApp_.user.username + `" type="text" name='sponsor[username]'></input>
              

              <button class="mt-4 btn btn-outline-primary checkUser">Check</button>
              <button class="mt-4 btn btn-primary disabled selectUser">Select this user</button>
            </div>
          </div>
          `,
            header: "Change Sponsor User"
          });
          $(".checkUser").click(() => {
            phxApp_.api(
              "get_accumulated_sales",
              {
                parent_id: memberApp_.user.id,
                show_rank: true,
                username: $("[name='sponsor[username]']").val()
              },
              () => {
                window.sponsorTarget = memberApp_.user.username;
                $("input[name='user[sponsor]']").val(window.sponsorTarget);
                $(".selectUser").addClass("disabled");
              },
              (res) => {
                $(".selectUser").removeClass("disabled");
                $(".pv-info").customHtml(`Accumulated sales PV: ` + res[0] + ` | Rank: ` + res[1]);
                if (res[2].is_direct_downline) {
                  $(".to-upgrade").removeClass("disabled");
                } else {
                  $("label[for='btnradio3']").click();
                  $(".to-upgrade").addClass("disabled");
                }
                if (res[3].is_downline) {
                  phxApp_.notify("User verified!");
                } else {
                  if ($("input[name='sponsor[username]']").val() == memberApp_.user.username) {
                    phxApp_.notify("User verified!");
                  } else {
                    phxApp_.notify("Not downline!", {
                      type: "warning"
                    });
                    $(".selectUser").addClass("disabled");
                  }
                }
              }
            );
          });
          $(".selectUser").click(() => {
            $("input[name='user[sponsor]']").val($("[name='sponsor[username]']").val());
            $("input[name='view[sponsor]']").val($("[name='sponsor[username]']").val());
            phxApp_.notify("User selected!");
            $("#mySubModal").modal("hide");
            window.sponsorTarget = $("[name='sponsor[username]']").val();
            $("#sponsorTarget").html($("[name='sponsor[username]']").val());
            commerceApp_.components["cartItems"]();
            console.info("need to check if member is direct sponsor");
          });
        });
      },
      stockistTarget() {
        window.stockistTarget;
        if (window.stockistTarget == null) {
          window.stockistTarget = memberApp_.user.username;
        } else {
        }
        $("input[name='user[stockist_user_id]']").val("");
        $("stockistTarget").customHtml(`<span>for: <span id="stockistTarget">` + window.stockistTarget + `</span>
       <a class="ms-4" href="javascript:void(0);" aria-stockist=true> <i class="fa fa-edit"></i> Change</a> </span>`);
        $("[aria-stockist]").click(() => {
          phxApp_.modal({
            selector: "#mySubModal",
            autoClose: false,
            content: `
          <div>
            <div class="form-group">
              <label>Username</label>
              <input class="my-2 form-control" value="` + memberApp_.user.username + `" type="text" name='sponsor[username]'></input>
              

              <button class="mt-4 btn btn-outline-primary checkUser">Check</button>
              <button class="mt-4 btn btn-primary disabled selectUser">Select this user</button>
            </div>
          </div>
          `,
            header: "Change Stockist User"
          });
          $(".checkUser").click(() => {
            phxApp_.api(
              "get_stockist",
              {
                parent_id: memberApp_.user.id,
                show_rank: true,
                username: $("[name='sponsor[username]']").val()
              },
              () => {
                window.stockistTarget = memberApp_.user.username;
                $("input[name='user[stockist_user_id]']").val(null);
                $(".selectUser").addClass("disabled");
              },
              (res) => {
                $(".selectUser").removeClass("disabled");
                if (res[1].is_stockist) {
                  window.stockistTargetData = res[2];
                  $("input[name='user[stockist_user_id]']").val(window.stockistTargetData.id);
                  phxApp_.notify("User verified!");
                } else {
                  phxApp_.notify("Not stockist!", {
                    type: "warning"
                  });
                  $(".selectUser").addClass("disabled");
                }
              }
            );
          });
          $(".selectUser").click(() => {
            $("input[name='user[stockist]']").val($("[name='sponsor[username]']").val());
            $("input[name='view[stockist]']").val($("[name='sponsor[username]']").val());
            phxApp_.notify("User selected!");
            $("#mySubModal").modal("hide");
            window.stockistTarget = $("[name='sponsor[username]']").val();
            $("#stockistTarget").html($("[name='sponsor[username]']").val());
            commerceApp_.components["cartItems"]();
          });
        });
      },
      salesItems() {
        var sale = phxApp_.api("get_sale", {
          id: pageParams.id
        });
        if (sale.status == "pending_payment") {
          if (sale.payment != null) {
            var res = phxApp_.api("check_bill", {
              id: sale.payment.billplz_code
            });
            if (res.paid == true) {
              phxApp_.notify("Payment updated!");
            }
          }
        }
        $("title").html("Order ID: " + sale.id);
        window.sale = sale;
        var count = 0, list = [], total_pv = 0, subtotal = 0;
        total_pv = sale.sales_items.map((v, i) => {
          return v.qty * v.item_pv;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        subtotal = sale.sales_items.map((v, i) => {
          return v.qty * v.item_price;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        count = sale.sales_items.map((v, i) => {
          return v.qty;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        shipping_fee = sale.shipping_fee || 0;
        eligible_rank = this.evalRank(subtotal);
        try {
          reg_dets = JSON.parse(sale.registration_details);
        } catch (e) {
          console.error(e);
        }
        var is_merchant = false;
        if (reg_dets.scope == "merchant_checkout") {
          total_pv = sale.total_point_value;
          is_merchant = true;
        }
        sale.sales_items.forEach((v, i) => {
          var img = "/images/placeholder.png";
          if (v.img_url != null) {
            try {
              img = v.img_url;
            } catch (e) {
              img = "/images/placeholder.png";
            }
          }
          var l2 = `  <span class="font-sm text-info "><span class="format-integer">` + v.item_pv * v.qty + `</span> PV</span>`;
          if (is_merchant) {
            l2 = "";
          }
          list.push(`

            <div class="d-flex align-items-center justify-content-between gap-2">
              <div class="d-flex align-items-center justify-content-between gap-2">
                <div class="d-flex justify-content-center align-items-center " style="
                                  cursor: pointer;   
                                  position: relative; 
                                  height: 60px;">
                  <div class="rounded py-2" style="
                                  height: 50px;
                                  width: 72%;
                                  filter: blur(4px);
                                  position: absolute;
                                  background-repeat: no-repeat;
                                  background-position: center;
                                  background-size: cover;
                                  background-image: url('` + img + `');
                                  bottom: 6px;
                                  left: 16px;
                                  ">
                  </div>
                  <div class="rounded py-2" style="
                                  height: 50px;
                                  width:  60px;
                                  z-index: 1;
                                  background-position: center;
                                  background-repeat: no-repeat;
                                  background-size: cover; 
                                  background-image: url('` + img + `');
                                  ">
                  </div>
                </div>
                <div class="d-flex flex-column">
                  <span>` + v.item_name + ` <small>(x` + v.qty + `)</small></span>
                  <div>` + v.remarks + `</div>
                </div>
              </div>
              <div class="d-flex flex-column flex-lg-row justify-content-between align-items-center">
                <div class="d-flex flex-column align-items-end">
                  <span class="font-sm ">RP <span class="format-float">` + (v.item_price * v.qty).toFixed(2) + `</span></span>
                ` + l2 + `
                </div>
               
              </div>
            </div>

          
            `);
        });
        var tpv = "Total PV";
        if (is_merchant) {
          tpv = "RP Received";
        }
        var payment_info = `

               <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-4">Subtotal</span>
                  <span class=" me-4">RP <span class="format-float">` + subtotal + `</span></span>
                </div>
               <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-4">Shipping</span>
                  <span class=" me-4">RP <span class="format-float">` + shipping_fee + `</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-5">` + tpv + `</span>
                  <span class="text-info me-4"><span class="format-integer">` + total_pv + ` PV</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fw-bold text-secondary">Eligible Rank</span>
                  <span class="text-info me-4"><span class="format-integer">` + eligible_rank + `</span></span>
                </div>

      `;
        try {
          shipping = reg_dets.user.shipping;
          console.log("shippnig...");
          console.info(shipping);
          payment = sale.payment;
        } catch (e) {
          console.error(e);
        }
        var drp_details = {};
        if (sale.payment != null) {
          if (sale.payment.payment_url != null) {
            payment_info = `

                 <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-4">Subtotal</span>
                    <span class=" ">RP <span class="format-float">` + subtotal + `</span></span>
                  </div>
                 <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-4">Shipping</span>
                    <span class=" me-4">RP <span class="format-float">` + shipping_fee + `</span></span>
                  </div>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-5">` + tpv + `</span>
                    <span class="text-info "><span class="format-integer">` + total_pv + ` PV</span></span>
                  </div>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-secondary">Eligible Rank</span>
                    <span class="text-info "><span class="format-integer">` + eligible_rank + `</span></span>
                  </div>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-secondary">Paid with</span>
                    <span class="text-primary "><span class="">` + payment.payment_method.split("_").map((v, i) => {
              return ColumnFormater.capitalize(v);
            }).join(" ") + `</span></span>
                  </div>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-secondary">Payment Link</span>
                    <span class="text-primary "><a target="_blank" href="` + payment.payment_url + `" class="">` + payment.payment_url + `</a></span>
                  </div>

        `;
          }
          try {
            console.info(sale.payment);
            if (sale.payment.webhook_details != null) {
              sale.payment.webhook_details.split("|").map((v, i) => {
                data = v.split(": ");
                var key = data[0].replace(" ", "_");
                console.log(key);
                drp_details[key] = parseFloat(data[1]);
              });
              console.info(drp_details);
              drp_amount = 0;
              var dpp = `DRP`;
              if (is_merchant) {
                dpp = "Merchant Point";
              }
              if (drp_details.drp_paid != null || drp_details.mp_paid != null) {
                drp_amount = drp_details.drp_paid;
                if (is_merchant) {
                  drp_amount = drp_details.mp_paid;
                }
              }
              if (drp_details.pp_paid != null) {
                total_pv = 0;
              }
              var tt4 = total_pv - drp_amount;
              var tt5 = subtotal + shipping_fee - drp_amount - (drp_details.rp_paid || 0);
              var elb = ` <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-secondary">Eligible Rank</span>
                    <span class="text-info "><span class="format-integer">` + eligible_rank + `</span></span>
                  </div>`;
              if (is_merchant) {
                elb = "";
                tt4 = total_pv;
                tt5 = subtotal + shipping_fee;
              }
              payment_info = `

                 <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-5">Subtotal</span>
                    <span class=" ">RP <span class="format-float">` + subtotal + `</span></span>
                  </div>
                 <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-5">Shipping + Tax</span>
                    <span class=" ">RP <span class="format-float">` + shipping_fee + `</span></span>
                  </div>

                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-5">` + dpp + `</span>
                    <span class=" ">- RP <span class="format-float">` + drp_amount + `</span></span>
                  </div>

                 <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-5">Grand Total </span>
                    <span class=" ">RP <span class="format-float">` + (subtotal + shipping_fee) + `</span></span>
                  </div>

                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-5">` + tpv + `</span>
                    <span class="text-info "><span class="format-integer">` + tt4 + ` PV</span></span>
                  </div>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-4">Grand Total  After Payment</span>
                    <span class=" ">RP <span class="format-float">` + tt5 + ` </span></span>
                  </div>

                 ` + elb + `
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-secondary">Paid with</span>
                    <span class="text-primary "><span class="">` + payment.payment_method.split("_").map((v, i) => {
                return ColumnFormater.capitalize(v);
              }).join(" ") + `</span></span>
                          </div>

                `;
            }
          } catch (e) {
            console.error(e);
          }
        }
        var addre = `      `;
        try {
          if (shipping != null) {
            addre = `
          <span class="text-secondary">Deliver To:</span> 
                           <span>` + shipping.line1 + `, ` + shipping.line2 + `</span>
                           <span>` + shipping.city + ` ` + shipping.postcode + `, ` + shipping.state + ` </span>

      `;
          } else {
            shipping = {
              phone: null,
              fullname: null
            };
          }
          if (sale.pick_up_point != null) {
            addre = `           <span class="text-secondary">Pick Up Point: </span>
                        <span>` + sale.pick_up_point.name + ` </span>
                      <span>` + sale.pick_up_point.address + ` </span>

          `;
          }
        } catch (e) {
          console.error(e);
        }
        console.info(addre);
        var print_or_check = `    <a class="btn btn-primary" href="/pdf?id=` + sale.id + `" target="_blank">Print</a>`;
        if (sale.payment == null && sale.status == "pending_payment") {
          print_or_check = `<div class="btn btn-success approve-sale" aria-id="` + sale.id + `">Approve</div>`;
        }
        if (sale.merchant_id != null) {
          print_or_check = `   <a class="btn btn-primary" href="/pdf?type=merchant&id=` + sale.id + `" target="_blank">Print</a>  <a class="d-none mdo btn btn-primary" href="/pdf?type=merchant_do&id=` + sale.id + `" target="_blank">Print DO</a>`;
        }
        console.info(sale);
        $("salesItems").customHtml(`
        <div class="d-flex align-items-center justify-content-between gap-2">
          <h2>Sales Details</h2><small class="badge bg-primary">` + sale.status + `</small>
        </div>
                <div class="d-flex flex-column mb-4 ">
                   <span class="text-secondary">Sold To:</span> 
                   <span>` + (reg_dets.user.fullname || phxApp_.user.fullname) + `, ` + (reg_dets.user.phone || phxApp_.user.phone) + `</span>
                   
                </div>
                <div class="d-flex flex-column mb-4 ">
                   <span class="text-secondary">Recipient:</span> 
                   <span>` + (shipping.fullname || phxApp_.user.fullname) + `, ` + (shipping.phone || phxApp_.user.phone) + `</span>
                   
                </div>


                <div class="d-flex flex-column mb-4 ">
                 
                    ` + addre + `
                </div>

                   <span class="text-secondary">Items:</span>
                <div class="d-flex flex-column gap-2">` + list.join("") + `
                ` + payment_info + `
                </div>
                <div class="my-4">
              ` + print_or_check + `
                </div>

        `);
        $(".approve-sale").click(function() {
          var id = $(this).attr("aria-id");
          phxApp_.modal({
            selector: "#mySubModal",
            content: `<div>

            <p>Approve this sale ?</p>

            <div class="btn btn-outline-primary confirm-approve">Approve</div>

            </div>`,
            header: "Confirmation",
            autoClose: false
          });
          $(".confirm-approve").click(() => {
            phxApp_.api("manual_approve_bank_in", {
              id
            });
          }, null, () => {
            phxApp_.navigateTo(location.pathname);
          });
        });
        ColumnFormater.formatDate();
      },
      evalStates() {
        $("select[name='user[shipping][state]']").customHtml(`<option></option>`);
        var malaysia = phxApp_.j.filter((v, i) => {
          return v.name == "Malaysia";
        })[0];
        if (malaysia.id == phxApp_.e.id) {
          if ($("[name='user[pick_up_point_id]']").val() == null) {
            $(".ss1").customHtml(`
                <select class="form-select" required id="s1" onchange="window.choosenAddress = null" name="user[shipping][state]">
                </select>
                <label class="ms-2" for="floatingInput">State</label>
          `);
          } else {
            $(".ss1").customHtml(`
                <select class="form-select"  id="s1" onchange="window.choosenAddress = null" name="user[shipping][state]">
                </select>
                <label class="ms-2" for="floatingInput">State</label>
          `);
          }
          var states = [
            ["jhr", "Johor"],
            ["kdh", "Kedah"],
            ["ktn", "Kelantan"],
            ["mlk", "Melaka"],
            ["nsn", "Negeri Sembilan"],
            ["phg", "Pahang"],
            ["prk", "Perak"],
            ["pls", "Perlis"],
            ["png", "Pulau Pinang"],
            ["sgr", "Selangor"],
            ["trg", "Terengganu"],
            ["kul", "Kuala Lumpur"],
            ["pjy", "Putra Jaya"],
            ["srw", "Sarawak"],
            ["sbh", "Sabah"],
            ["lbn", "Labuan"]
          ];
          states.forEach((v, i) => {
            if (window.selectedState == v[1]) {
              $("select[name='user[shipping][state]']").append(`
              <option selected value="` + v[1] + `">` + v[1] + `</option>`);
            } else {
              $("select[name='user[shipping][state]']").append(`
              <option value="` + v[1] + `">` + v[1] + `</option>`);
            }
          });
          $("select[name='user[shipping][state]']").change(() => {
            window.selectedState = $("select[name='user[shipping][state]']").val();
            commerceApp_.components["updateCart"]();
            commerceApp_.components["cartItems"]();
          });
        } else {
          if ($("[name='user[pick_up_point_id]']").val() == null) {
            $(".ss1").customHtml(`
                <input class="form-control" required id="s1" onchange="window.choosenAddress = null" name="user[shipping][state]">
                </input>
                <label class="ms-2" for="floatingInput">State</label>
          `);
          } else {
            $(".ss1").customHtml(`
                <input class="form-control"  id="s1" onchange="window.choosenAddress = null" name="user[shipping][state]">
                </input>
                <label class="ms-2" for="floatingInput">State</label>
          `);
          }
        }
      },
      evalShipping(subtotal) {
        var is_merchant = $("cartItems").attr("merchant") == "" ? true : false;
        var s = 0;
        var malaysia = phxApp_.j.filter((v, i) => {
          return v.name == "Malaysia";
        })[0];
        var singapore = phxApp_.j.filter((v, i) => {
          return v.name == "Singapore";
        })[0];
        if (malaysia.id == phxApp_.e.id) {
          if ($("[name='user[pick_up_point_id]']").val() != "") {
            s = 0;
          } else {
            if (["Sabah", "Sarawak", "Labuan"].includes(window.selectedState)) {
              s = Math.ceil(subtotal / 200) * 4;
            } else {
              if (is_merchant) {
                s = Math.ceil(subtotal / 200) * 2;
              } else {
                if (subtotal >= 100) {
                  s = 0;
                } else {
                  s = 2;
                }
              }
            }
          }
        } else {
          s = subtotal * 0.1;
          if (singapore.id == phxApp_.e.id) {
            s = subtotal * 0.05;
            if (is_merchant) {
              s = subtotal * 0.1;
            }
          }
        }
        return s;
      },
      evalShippingAddresses() {
        try {
          phxApp_.api("list_pick_up_point_by_country", {
            country_id: phxApp_.e.id
          }, null, (list) => {
            phxApp_.pick_up_points = list;
            if ($("[name='user[pick_up_point_id]']").length > 0) {
              if ($("[name='user[pick_up_point_id]']").val() != "") {
                var id = $("[name='user[pick_up_point_id]']").val();
                var pup = phxApp_.pick_up_points.filter((v, i) => {
                  return v.id == id;
                })[0];
                try {
                  $("[name='user[shipping][state]']").removeAttr("required");
                  console.log("attr removed");
                  $(".self-pickup-form").customHtml(`
                   <div class="d-flex flex-column">
                      <span>` + pup.name + `</span>
                      <span class="text-secondary">` + pup.address + `</span>
                      <span class="mt-4">
                      </span>
                    </div>

            `);
                } catch (e) {
                  $(".shipping-form").removeClass("d-none");
                  $(".self-pickup-form").addClass("d-none");
                  phxApp_.notify("No pick up points in this region", {
                    type: "danger"
                  });
                }
              }
            }
            var adds = [];
            list.forEach((v, i) => {
              adds.push(`
              <div class="card my-2" style="cursor: pointer;">
                <div class="card-body">
                  <div class="d-flex flex-column">
                    <span>` + v.name + `</span>
                    <span class="text-secondary">` + v.address + `</span>
                    <span class="mt-4">
                      <div class="btn btn-primary" aria-address="` + v.id + `">Choose</div>
                    </span>
                  </div>
                </div>
              </div>
            `);
            });
            $(".self-pickup").unbind();
            $(".self-pickup").click(() => {
              window.selectedState = null;
              $(".shipping-form").addClass("d-none");
              $(".self-pickup-form").removeClass("d-none");
              phxApp_.modal({
                autoClose: false,
                selector: "#mySubModal",
                content: `
            <div class="d-flex flex-column">
              ` + adds.join("") + `
            </div>
            `,
                header: "Pick Up Points"
              });
              $("[aria-address]").click(function() {
                var id2 = $(this).attr("aria-address");
                var pup2 = phxApp_.pick_up_points.filter((v, i) => {
                  return v.id == id2;
                })[0];
                try {
                  $("[name='user[shipping][state]']").removeAttr("required");
                  console.log("attr removed");
                  $(".self-pickup-form").customHtml(`
                   <div class="d-flex flex-column">
                      <span>` + pup2.name + `</span>
                      <span class="text-secondary">` + pup2.address + `</span>
                      <span class="mt-4">
                      </span>
                    </div>

            `);
                } catch (e) {
                  $(".shipping-form").removeClass("d-none");
                  $(".self-pickup-form").addClass("d-none");
                  phxApp_.notify("No pick up points in this region", {
                    type: "danger"
                  });
                }
                $("[name='user[pick_up_point_id]']").val(id2);
                $("#mySubModal").modal("hide");
                $("[name='user[shipping][state]']").val(null);
                commerceApp_.components["cartItems"]();
              });
            });
          });
          if (pageParams.share_code != null) {
          } else {
            phxApp_.api("list_user_sales_addresses_by_username", {
              username: phxApp_.user.username
            }, null, (list) => {
              phxApp_.addresses = list;
              if (list.length > 0) {
                if (window.choosenAddress != null) {
                  var address = list.filter((v, i) => {
                    return v.id == window.choosenAddress;
                  })[0];
                  $("[name='user[shipping][phone]']").val(address.phone);
                  $("[name='user[shipping][fullname]']").val(address.fullname);
                  $("[name='user[shipping][line1]']").val(address.line1);
                  $("[name='user[shipping][line2]']").val(address.line2);
                  $("[name='user[shipping][city]']").val(address.city);
                  $("[name='user[shipping][postcode]']").val(address.postcode);
                  setTimeout(() => {
                    $("[name='user[shipping][state]']").val(address.state);
                  }, 500);
                }
              }
              $(".change-address").unbind();
              var adds = [];
              list.forEach((v, i) => {
                adds.push(`
              <div class="card my-2" style="cursor: pointer;">
                <div class="card-body">
                  <div class="d-flex flex-column">
                    <span>` + v.fullname + `</span>
                    <span class="text-secondary">` + v.line1 + `, ` + v.line2 + `</span>
                    <span class="mt-4">
                      <div class="btn btn-primary" aria-address="` + v.id + `">Choose</div>
                    </span>
                  </div>
                </div>
              </div>
            `);
              });
              $(".change-address").click(() => {
                $("[name='user[pick_up_point_id]']").val("");
                $(".shipping-form").removeClass("d-none");
                $(".self-pickup-form").addClass("d-none");
                $("[name='user[shipping][state]']").attr("required");
                console.log("attr add");
                phxApp_.modal({
                  autoClose: false,
                  selector: "#mySubModal",
                  content: `
            <div class="d-flex flex-column">
              ` + adds.join("") + `
            </div>
            `,
                  header: "Change address"
                });
                $("[aria-address]").click(function() {
                  var id = $(this).attr("aria-address");
                  window.choosenAddress = id;
                  var address2 = phxApp_.addresses.filter((v, i) => {
                    return v.id == id;
                  })[0];
                  $("[name='user[shipping][phone]']").val(address2.phone);
                  $("[name='user[shipping][fullname]']").val(address2.fullname);
                  $("[name='user[shipping][line1]']").val(address2.line1);
                  $("[name='user[shipping][line2]']").val(address2.line2);
                  $("[name='user[shipping][city]']").val(address2.city);
                  $("[name='user[shipping][postcode]']").val(address2.postcode);
                  setTimeout(() => {
                    $("[name='user[shipping][state]']").val(address2.state);
                  }, 500);
                  $("#mySubModal").modal("hide");
                  commerceApp_.components["cartItems"]();
                });
              });
            });
          }
        } catch (e) {
          console.error(e);
        }
      },
      cartItems() {
        var is_merchant = $("cartItems").attr("merchant") == "" ? true : false;
        const cart = is_merchant ? commerceApp_.g : commerceApp_.f;
        var hasOverride = false, count = 0, shipping_fee2 = 2, list = [], total_pv = 0, subtotal = 0;
        total_pv = cart.map((v, i) => {
          return v.qty * v.point_value;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        subtotal = cart.map((v, i) => {
          return v.qty * v.retail_price;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        if (is_merchant) {
          total_pv = subtotal;
        }
        count = cart.map((v, i) => {
          return v.qty;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        this.evalShippingAddresses();
        this.evalStates();
        if ($("cartItems").attr("upgrade") != null) {
          if (window.upgradeTarget != null) {
            accumulated_sales = phxApp_.api("get_accumulated_sales", {
              username: window.upgradeTarget
            });
            subtotal = subtotal;
            eligible_rank = this.evalRank(subtotal + accumulated_sales);
          } else {
            subtotal = subtotal;
            eligible_rank = this.evalRank(subtotal + memberApp_.user.rank.retail_price);
          }
          $(".only-downline").click(() => {
            phxApp_.notify("Only available for direct recruited downline.");
          });
        } else {
          eligible_rank = this.evalRank(subtotal);
        }
        shipping_fee2 = this.evalShipping(subtotal);
        cart.forEach((v, i) => {
          var lpv = `<span class="font-sm text-info "><span class="format-integer">` + v.point_value * v.qty + `</span> PV</span>`;
          if (is_merchant) {
            lpv = ``;
          }
          var img = "/images/placeholder.png";
          if (v.img_url != null) {
            try {
              img = v.img_url;
            } catch (e) {
              img = "/images/placeholder.png";
            }
          }
          var linePassed = "";
          if (cart == commerceApp_.cart && parseInt(localStorage.first_cart_country_id) != phxApp_.e.id) {
            linePassed = `border border-danger`;
            list.push(`

            <div class="d-flex align-items-center justify-content-between gap-2 ` + linePassed + ` rounded p-2 me-3">
           
              <div class="d-flex align-items-center justify-content-between gap-2">
                <div class="d-flex justify-content-center align-items-center " style="
                                  cursor: pointer;   
                                  position: relative; 
                                  height: 60px;">
                  <div class="rounded py-2" style="
                                  height: 50px;
                                  width: 72%;
                                  filter: blur(4px);
                                  position: absolute;
                                  background-repeat: no-repeat;
                                  background-position: center;
                                  background-size: cover;
                                  background-image: url('` + img + `');
                                  bottom: 6px;
                                  left: 16px;
                                  ">
                  </div>
                  <div class="rounded py-2" style="
                                  height: 50px;
                                  width:  60px;
                                  z-index: 1;
                                  background-position: center;
                                  background-repeat: no-repeat;
                                  background-size: cover; 
                                  background-image: url('` + img + `');
                                  ">
                  </div>
                </div>
                <span>` + v.name + ` <small>(x` + v.qty + `)</small> <br><small> <i class="fa fa-exclamation-triangle text-danger "></i>Product not available for this region</small></span>
              </div>
              <div class="d-flex flex-column flex-lg-row justify-content-between align-items-center">
                
                <div class="text-center">
                  <div class="btn btn-sm" delete-product-id="` + v.id + `"><i class="text-danger fa fa-times"></i></div>
                </div>
              </div>
            </div>

          
            `);
          } else {
            if (v.override_pv) {
              hasOverride = true;
            }
            var rp = `RP <span class="format-float">` + (v.retail_price * v.qty).toFixed(2);
            if (showRP == false) {
              rp = `MYR <span class="format-float">` + (v.retail_price * v.qty * phxApp_.e.conversion).toFixed(2);
            }
            var instalment_input = ``, instalment_info = ``;
            if (v.selectedInstalmentId != null) {
              var instalment = v.selectedInstalment;
              try {
                instalment_info = `<div class="text-sm text-secondary">` + instalment.name + `</div>`;
                instalment_input = `<input type="hidden"  name="user[products][` + i + `][remarks]" value="instalment_product_id:` + v.selectedInstalmentId + `">`;
              } catch (e) {
                console.error(e);
              }
            }
            try {
              if ($("input[name='user[instalment]']").val() != null) {
                var form_instalment_info = $("input[name='user[instalment]']").val();
                instalment_info = form_instalment_info;
              }
            } catch (e) {
              console.error(e);
            }
            list.push(`

              <div class="d-flex align-items-center justify-content-between gap-2 ` + linePassed + ` rounded p-2 me-3">
              <input type="hidden"  name="user[products][` + i + `][item_name]" value="` + v.name + `">
              <input type="hidden"  name="user[products][` + i + `][item_price]" value="` + v.retail_price + `">
              <input type="hidden"  name="user[products][` + i + `][item_pv]" value="` + v.point_value + `">
              <input type="hidden"  name="user[products][` + i + `][img_url]" value="` + v.img_url + `">
              <input type="hidden"  name="user[products][` + i + `][qty]" value="` + v.qty + `">
              ` + instalment_input + `
                <div class="d-flex align-items-center justify-content-between gap-2">
                  <div class="d-flex justify-content-center align-items-center " style="
                                    cursor: pointer;   
                                    position: relative; 
                                    height: 60px;">
                    <div class="rounded py-2" style="
                                    height: 50px;
                                   width: 72%;
                                    filter: blur(4px);
                                    position: absolute;
                                    background-repeat: no-repeat;
                                    background-position: center;
                                    background-size: cover;
                                    background-image: url('` + img + `');
                                    bottom: 6px;
                                    left: 16px;
                                    ">
                    </div>
                    <div class="rounded py-2" style="
                                    height: 50px;
                                    width:  60px;
                                    z-index: 1;
                                    background-position: center;
                                    background-repeat: no-repeat;
                                    background-size: cover; 
                                    background-image: url('` + img + `');
                                    ">
                    </div>
                  </div>
                  <div class="d-flex flex-column">
                    <span>` + v.name + ` <small>(x` + v.qty + `)</small></span>
                    ` + instalment_info + `
                  </div>
                </div>
                <div class="d-flex flex-column flex-lg-row justify-content-between align-items-center">
                  <div class="d-flex flex-column align-items-end">
                    <span class="font-sm ">` + rp + `</span></span>
                    ` + lpv + `
                  </div>
                  <div class="text-center">
                    <div class="btn btn-sm" add-product-id="` + v.id + `"><i class="text-info fa fa-plus"></i></div>
                    <div class="btn btn-sm" minus-product-id="` + v.id + `"><i class="text-danger fa fa-minus"></i></div>
                    <div class="btn btn-sm" delete-product-id="` + v.id + `"><i class="text-danger fa fa-times"></i></div>
                  </div>
                </div>
              </div>

            
              `);
          }
        });
        var has_instalment_info = false;
        try {
          if ($("input[name='user[instalment]']").val() != null) {
            has_instalment_info = true;
          }
        } catch (e) {
          console.error(e);
        }
        try {
          if ($("input[name='user[stockist_user_id]']").val() != null) {
            shipping_fee2 = 0;
          }
        } catch (e) {
          console.error(e);
        }
        if (has_instalment_info) {
          shipping_fee2 = 0;
        }
        console.log("merchant?");
        console.log(is_merchant);
        if (is_merchant) {
          shipping_fee2 = subtotal * 0.025;
          shipping_fee2 = 0;
        }
        var currency = `RP`, srp = subtotal + shipping_fee2, cshipping_fee = shipping_fee2, elr = `

                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-secondary">Eligible Rank</span>
                    <span class="text-info me-4"><span class="format-integer">` + eligible_rank + `</span></span>
                  </div>

    `, tpv = `

      Total PV

    `, crp = `RP <span class="format-float">` + subtotal;
        if (is_merchant) {
          elr = "";
          tpv = `RP received`;
        }
        if (!showRP) {
          crp = `MYR <span class="format-float">` + subtotal * phxApp_.e.conversion;
          cshipping_fee = shipping_fee2 * phxApp_.e.conversion;
          srp = (subtotal + shipping_fee2) * phxApp_.e.conversion;
          currency = `MYR`;
        }
        $("cartItems").customHtml(`

                  <div class="d-flex flex-column gap-1">` + list.join("") + `
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fw-bold">Subtotal</span>
                      <span class=" me-4">` + crp + `</span></span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fw-bold">Shipping_Tax</span>
                      <span class=" me-4">` + currency + ` <span class="format-float">` + cshipping_fee + `</span></span>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fs-4">Grand Total</span>
                      <span class=" me-4">` + currency + ` <span class="format-float fs-4">` + srp + `</span></span>
                    </div>
                  <div class="d-flex justify-content-between align-items-center pv_label d-none">
                    <span class="fs-5">` + tpv + `</span>
                    <span class="text-info me-4"><span class="format-integer">` + total_pv + ` PV</span></span>
                  </div>
                  ` + elr + `

                </div>

 

        `);
        var user = memberApp_.user, wallets = [];
        if (user != null) {
          if (user.wallets == null) {
            wallets = phxApp_.api("user_wallet", {
              token: user.token
            });
            user.wallets = wallets;
          } else {
            wallets = user.wallets;
          }
        }
        function appendWalletAttr() {
          if (wallets.length == 0) {
          } else {
            $("wallet").each((i, v) => {
              var check2 = wallets.filter((wv, wi) => {
                return wv.wallet_type == "direct_recruitment";
              });
              if (is_merchant) {
                check2 = wallets.filter((wv, wi) => {
                  return wv.wallet_type == "merchant";
                });
              }
              if (check2.length > 0) {
                var wallet = check2[0];
                if (is_merchant) {
                  $("#drp_payment").attr("max", subtotal * 0.2);
                  $("#drp_payment").attr("min", 0);
                  $("#drp_payment").attr("step", 0.01);
                  $("#drp_payment").attr("value", subtotal * 0.2);
                } else {
                  if (hasOverride) {
                    var reg_pv = subtotal * 0.7;
                    console.info("here ovier");
                    var subtotal2 = cart.map((v2, i2) => {
                      return v2.qty * v2.retail_price * v2.override_perc;
                    }).reduce((a, b) => {
                      return a + b;
                    }, 0);
                    $("#drp_payment").attr("min", Math.round(subtotal2));
                    $("#drp_payment").attr("value", Math.round(subtotal2));
                  } else {
                    $("#drp_payment").attr("max", wallet.total);
                    $("#drp_payment").attr("min", Math.round(subtotal * 0.5));
                    $("#drp_payment").attr("value", Math.round(subtotal * 0.5));
                  }
                }
              } else {
              }
            });
          }
        }
        $("input[name='user[payment][method]']").unbind();
        $("input[name='user[payment][method]']").on("change", () => {
          $("#coupon-detail").addClass("d-none");
          $("input[name='user[payment][method]']").each((i, v) => {
            if ($(v)[0].checked == true) {
              if (["register_point", "merchant_point"].includes($(v).val())) {
                $("#coupon-detail").removeClass("d-none");
                drpChanged();
              } else {
                $("#drp_payment").removeAttr("max");
                $("#drp_payment").removeAttr("min");
                $("#drp_payment").removeAttr("value");
                if (is_merchant) {
                  commerceApp_.components["updateMCart"]();
                } else {
                  commerceApp_.components["updateCart"]();
                }
                commerceApp_.components["cartItems"]();
              }
            }
          });
        });
        function drpChanged() {
          appendWalletAttr();
          var drp_amount2 = 0, shipping_fee3 = 2, tt3 = 0, tt4 = 0;
          if ($("#drp_payment").length > 0) {
            try {
              drp_amount2 = parseFloat($("#drp_payment").val());
            } catch (e) {
              drp_amount2 = $("#drp_payment").val();
            }
          }
          shipping_fee3 = commerceApp_.components.evalShipping(subtotal);
          if (has_instalment_info) {
            shipping_fee3 = 0;
          }
          tt3 = subtotal + shipping_fee3 - drp_amount2;
          tt4 = total_pv - drp_amount2;
          if (is_merchant) {
            shipping_fee3 = subtotal * 0.025;
            shipping_fee3 = 0;
            tt3 = subtotal + shipping_fee3;
            console.log("w");
            tt4 = subtotal - drp_amount2 + shipping_fee3;
          } else {
          }
          var drpa = `


                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fw-bold">DRP</span>
                      <span class=" me-4">- RP <span class="format-float">` + drp_amount2 + `</span></span>
                    </div>
        `;
          if (is_merchant) {
            drpa = `


                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fw-bold">MP</span>
                      <span class=" me-4">- RP <span class="format-float">` + drp_amount2 + `</span></span>
                    </div>
          `;
          }
          $("cartItems").customHtml(`

                  <div class="d-flex flex-column gap-1">` + list.join("") + `
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fw-bold">Subtotal</span>
                      <span class=" me-4">RP <span class="format-float">` + subtotal + `</span></span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fw-bold">Shipping_Tax</span>
                      <span class=" me-4">RP <span class="format-float">` + shipping_fee3 + `</span></span>
                    </div>
                    ` + drpa + `
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fs-4">Grand Total</span>
                      <span class=" me-4">RP <span class="format-float fs-4">` + tt3 + `</span></span>
                    </div>

                    <div class="d-flex justify-content-between align-items-center pv_label d-none">
                      <span class="fs-5">` + tpv + `</span>
                      <span class="text-info me-4"><span class="format-integer">` + tt4 + ` PV</span></span>
                    </div>
                   ` + elr + `
                  </div>


          `);
          if (is_merchant) {
            $("cartItems").customHtml(`

                            <div class="d-flex flex-column gap-1">` + list.join("") + `
                              <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-bold">Subtotal</span>
                                <span class=" me-4">RP <span class="format-float">` + subtotal + `</span></span>
                              </div>
                              <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-bold">Shipping_Tax</span>
                                <span class=" me-4">RP <span class="format-float">` + shipping_fee3 + `</span></span>
                              </div>
                              ` + drpa + `
                              <div class="d-flex justify-content-between align-items-center">
                                <span class="fs-4">Grand Total</span>
                                <span class=" me-4">RP <span class="format-float fs-4">` + tt4 + `</span></span>
                              </div>

                              <div class="d-flex justify-content-between align-items-center pv_label d-none">
                                <span class="fs-5">` + tpv + `</span>
                                <span class="text-info me-4"><span class="format-integer">` + tt4 + ` PV</span></span>
                              </div>
                             ` + elr + `
                            </div>


                    `);
          }
          ColumnFormater.formatDate();
          $("[add-product-id]").each((i, v) => {
            var id = $(v).attr("add-product-id");
            function addItem() {
              commerceApp_.z(id, is_merchant);
              if (is_merchant) {
                commerceApp_.components["updateMCart"]();
              } else {
                commerceApp_.components["updateCart"]();
              }
              commerceApp_.components["cartItems"]();
              commerceApp_.toastChanges();
            }
            $(v)[0].onclick = addItem;
          });
          $("[minus-product-id]").each((i, v) => {
            var id = $(v).attr("minus-product-id");
            function minusItem() {
              commerceApp_.v(id, is_merchant);
              if (is_merchant) {
                commerceApp_.components["updateMCart"]();
              } else {
                commerceApp_.components["updateCart"]();
              }
              commerceApp_.components["cartItems"]();
              commerceApp_.toastChanges();
            }
            $(v)[0].onclick = minusItem;
          });
          $("[delete-product-id]").each((i, v) => {
            var id = $(v).attr("delete-product-id");
            function deleteItem() {
              commerceApp_.q(id, is_merchant);
              if (is_merchant) {
                commerceApp_.components["updateMCart"]();
              } else {
                commerceApp_.components["updateCart"]();
              }
              commerceApp_.components["cartItems"]();
              commerceApp_.toastChanges();
            }
            $(v)[0].onclick = deleteItem;
          });
        }
        function drpChangeHandler(event) {
          $("#drp_payment").removeAttr("max");
          $("#drp_payment").removeAttr("min");
          $("#drp_payment").removeAttr("value");
          drpChanged();
        }
        drp_elem = document.getElementById("drp_payment");
        if (drp_elem != null) {
          drp_elem.removeEventListener("change", drpChangeHandler);
          drp_elem.addEventListener("change", drpChangeHandler);
        }
        $("[add-product-id]").each((i, v) => {
          var id = $(v).attr("add-product-id");
          function addItem() {
            commerceApp_.z(id, is_merchant);
            if (is_merchant) {
              commerceApp_.components["updateMCart"]();
            } else {
              commerceApp_.components["updateCart"]();
            }
            commerceApp_.components["cartItems"]();
            commerceApp_.toastChanges();
          }
          $(v)[0].onclick = addItem;
        });
        $("[minus-product-id]").each((i, v) => {
          var id = $(v).attr("minus-product-id");
          function minusItem() {
            commerceApp_.v(id, is_merchant);
            if (is_merchant) {
              commerceApp_.components["updateMCart"]();
            } else {
              commerceApp_.components["updateCart"]();
            }
            commerceApp_.components["cartItems"]();
            commerceApp_.toastChanges();
          }
          $(v)[0].onclick = minusItem;
        });
        $("[delete-product-id]").each((i, v) => {
          var id = $(v).attr("delete-product-id");
          function deleteItem() {
            commerceApp_.q(id, is_merchant);
            if (is_merchant) {
              commerceApp_.components["updateMCart"]();
            } else {
              commerceApp_.components["updateCart"]();
            }
            commerceApp_.components["cartItems"]();
            commerceApp_.toastChanges();
          }
          $(v)[0].onclick = deleteItem;
        });
        $("input[name='user[payment][method]']").each((i, v) => {
          if ($(v)[0].checked == true) {
            if (["register_point", "merchant_point"].includes($(v).val())) {
              $("#coupon-detail").removeClass("d-none");
              drpChanged();
            } else {
              $("#drp_payment").removeAttr("max");
              $("#drp_payment").removeAttr("min");
              $("#drp_payment").removeAttr("value");
            }
          }
        });
        ColumnFormater.formatDate();
      },
      evalRank(subtotal) {
        var sort = [];
        memberApp_.ranks.map((v, i) => {
          sort.push(v);
        });
        sort.sort((a, b) => {
          return b.retail_price - a.retail_price;
        });
        check = sort.filter((v, i) => {
          return v.retail_price <= subtotal;
        })[0];
        var eligible_rank2 = "n/a";
        console.log(eligible_rank2);
        if (check) {
          eligible_rank2 = check.name;
          if ($("input[name='user[rank_id]']").length > 0) {
            $("input[name='user[rank_id]']").val(check.id);
          }
        }
        return eligible_rank2;
      },
      updateCart() {
        var count = 0, list = [], subtotal = 0;
        subtotal = commerceApp_.f.map((v, i) => {
          return v.qty * v.retail_price;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        count = commerceApp_.f.map((v, i) => {
          return v.qty;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        $(".bc").html(count);
        commerceApp_.f.forEach((v, i) => {
          var frp = `<div class="font-sm">RP <span class="font-sm format-float">` + (v.retail_price * v.qty).toFixed(2) + `</span></div>`;
          if (!showRP) {
            frp = `<div class="font-sm">MYR <span class="font-sm format-float">` + (v.retail_price * v.qty * phxApp_.e.conversion).toFixed(2) + `</span></div>`;
          }
          list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">
            <div style="width: 240px;" class="d-flex justify-content-between align-items-center">
              <span>` + v.name + ` <small>(x` + v.qty + `)</small></span>
              <div class="d-flex align-items-center justify-content-between gap-2">
                ` + frp + `

                <div class="d-lg-block d-none">
                  <div class="btn btn-sm" minus-product-id="` + v.id + `"><i class="text-danger fa fa-minus"></i></div>
                  <div class="btn btn-sm" delete-product-id="` + v.id + `"><i class="text-danger fa fa-times"></i></div>
                </div>
                

              </div>
            </div>

          </a></li>

            `);
        });
        if (list.length == 0) {
          list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">Empty</a></li>

            `);
        }
        var bg_ranks2 = [], sort = [];
        memberApp_.ranks.map((v, i) => {
          sort.push(v);
        });
        sort.sort((a, b) => {
          return a.retail_price - b.retail_price;
        });
        sort.map((v, i) => {
          bg_ranks2.push(`
          <div class="col ">
            <div class="d-flex flex-column">
              <span>` + v.name + `</span>
              <span class="format-float">` + v.retail_price + `</span>
              
            </div>
          </div>`);
        });
        if ($("cartItems").attr("upgrade") != null) {
          if (window.upgradeTarget != null) {
            accumulated_sales = phxApp_.api("get_accumulated_sales", {
              username: window.upgradeTarget
            });
            subtotal = subtotal;
            console.log(subtotal);
            eligible_rank = this.evalRank(subtotal + accumulated_sales);
          } else {
            subtotal = subtotal;
            console.log(subtotal);
            eligible_rank = this.evalRank(subtotal + memberApp_.user.rank.retail_price);
          }
          $(".only-downline").click(() => {
            phxApp_.notify("Only available for direct recruited downline.");
          });
        } else {
          subtotal = subtotal;
          console.log(subtotal);
          eligible_rank = this.evalRank(subtotal);
        }
        bg_ranks = [
          `  <div class="progress-bar bg-danger" role="progressbar" style="width: 15%;" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>`,
          `  <div class="progress-bar bg-warning" role="progressbar" style="width: 30%;" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>`,
          `  <div class="progress-bar bg-info" role="progressbar" style="width: 20%;" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>`
        ];
        rankSubtotal = memberApp_.ranks.sort((a, b) => {
          return a.retail_price - b.retail_price;
        }).findIndex((item) => item.name === eligible_rank);
        console.log(rankSubtotal);
        perc = (rankSubtotal + 1) * 25;
        $(".ac").each((i, vv) => {
          var html2 = list.join("") + `
                <li id="divider">
                  <hr class="dropdown-divider">
                </li>
               <li>                  

               <a class="dropdown-item navi" href="/register">
                    <div class="d-flex flex-column">
                      <div class="d-flex justify-content-between align-items-center">
                        <span>Checkout</span>
                        <span class="format-float">` + subtotal + `</span>
                      </div>
                   

                      <div class="d-flex justify-content-between align-items-center">
                        <small>Eligible</small>
                        <small class="text-info">` + eligible_rank + `</small>
                      </div>

                      <div class="progress my-2" style="height: 4px;">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ` + perc + `%;" aria-valuenow="` + perc + `" aria-valuemin="0" aria-valuemax="100"></div>
                      </div>
                      <div class="row text-sm">
                        ` + bg_ranks2.join("") + `
                      </div>

                    
                    </div>
                  </a>
                </li>`;
          $(vv).html(html2);
        });
        $("[minus-product-id]").each((i, v) => {
          var id = $(v).attr("minus-product-id");
          function minusItem() {
            commerceApp_.v(id);
            commerceApp_.components["updateCart"]();
            commerceApp_.toastChanges();
          }
          $(v)[0].onclick = minusItem;
        });
        $("[delete-product-id]").each((i, v) => {
          var id = $(v).attr("delete-product-id");
          function deleteItem() {
            commerceApp_.q(id);
            commerceApp_.components["updateCart"]();
            commerceApp_.toastChanges();
          }
          $(v)[0].onclick = deleteItem;
        });
        ColumnFormater.formatDate();
      },
      updateMCart() {
        var count = 0, list = [], subtotal = 0;
        subtotal = commerceApp_.g.map((v, i) => {
          return v.qty * v.retail_price;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        count = commerceApp_.g.map((v, i) => {
          return v.qty;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        $(".mbc").html(count);
        commerceApp_.g.forEach((v, i) => {
          list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">
            <div style="width: 240px;" class="d-flex justify-content-between align-items-center">
              <span>` + v.name + ` <br><small>(x` + v.qty + `)</small></span>
              <div class="d-flex align-items-center justify-content-between gap-2">
                <span class="font-sm format-float">` + (v.retail_price * v.qty).toFixed(2) + `</span>

             
                

              </div>
            </div>

          </a></li>

            `);
        });
        if (list.length == 0) {
          list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">Empty</a></li>

            `);
        }
        $(".mac").each((i, vv) => {
          var html2 = list.join("") + `
                <li id="divider">
                  <hr class="dropdown-divider">
                </li>
               <li>                  

               <a class="dropdown-item navi" href="/merchant_checkout">
                    <div class="d-flex flex-column">
                      <div class="d-flex justify-content-between align-items-center">
                        <span>Checkout</span>
                        <span class="format-float">` + subtotal + `</span>
                      </div>
                
                    </div>
                  </a>
                </li>`;
          $(vv).html(html2);
        });
        $("[minus-product-id]").each((i, v) => {
          var id = $(v).attr("minus-product-id");
          function minusItem() {
            commerceApp_.v(id, true);
            commerceApp_.components["updateMCart"]();
            commerceApp_.toastChanges();
          }
          $(v)[0].onclick = minusItem;
        });
        $("[delete-product-id]").each((i, v) => {
          var id = $(v).attr("delete-product-id");
          function deleteItem() {
            commerceApp_.q(id, true);
            commerceApp_.components["updateMCart"]();
            commerceApp_.toastChanges();
          }
          $(v)[0].onclick = deleteItem;
        });
        ColumnFormater.formatDate();
      },
      cart() {
        var count = 0, list = [], subtotal = 0;
        subtotal = commerceApp_.f.map((v, i) => {
          return v.qty * v.retail_price;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        count = commerceApp_.f.map((v, i) => {
          return v.qty;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        commerceApp_.f.forEach((v, i) => {
          var frp = `<div class="font-sm">RP <span class="font-sm format-float">` + (v.retail_price * v.qty).toFixed(2) + `</span></div>`;
          if (!showRP) {
            frp = `<div class="font-sm">MYR <span class="font-sm format-float">` + (v.retail_price * v.qty * phxApp_.e.conversion).toFixed(2) + `</span></div>`;
          }
          list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">
            <div style="width: 240px;" class="d-flex justify-content-between align-items-center">
              <span>` + v.name + ` <small>(x` + v.qty + `)</small></span>
              <div class="d-flex align-items-center justify-content-between gap-2">
               ` + frp + `


                <div class="d-lg-block d-none">
                  <div class="btn btn-sm" minus-product-id="` + v.id + `"><i class="text-danger fa fa-minus"></i></div>
                  <div class="btn btn-sm" delete-product-id="` + v.id + `"><i class="text-danger fa fa-times"></i></div>
                </div>

              </div>
            </div>

          </a></li>

            `);
        });
        if (list.length == 0) {
          list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">Empty</a></li>

            `);
        }
        var bg_ranks2 = [], sort = [];
        memberApp_.ranks.map((v, i) => {
          sort.push(v);
        });
        sort.sort((a, b) => {
          return a.retail_price - b.retail_price;
        });
        sort.map((v, i) => {
          bg_ranks2.push(`
          <div class="col ">
            <div class="d-flex flex-column">
              <span>` + v.name + `</span>
              <span class="format-float">` + v.retail_price + `</span>
              
            </div>
          </div>`);
        });
        if ($("cartItems").attr("upgrade") != null) {
          subtotal = subtotal + memberApp_.user.rank.retail_price;
        }
        eligible_rank = this.evalRank(subtotal);
        perc = subtotal / memberApp_.ranks[0].retail_price * 100;
        $("cart").each((i, v) => {
          var needDropUp = `dropstart`;
          if ($(v).attr("dropup") != null) {
            needDropUp = `dropup`;
          }
          $(v).customHtml(`
            <div class="` + needDropUp + `  ">
              <div class="mx-3 py-2 btn btn-outline-success rounded-xl position-relative"  data-bs-toggle="dropdown" aria-expanded="false">
                <div style="top: 4px !important;" class="badge bg-warning position-absolute top-0 start-100 translate-middle bc">` + count + `</div>
                <i class="fa fa-shopping-cart"></i>
              </div>
              <ul class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start ac">
                ` + list.join("") + `
                <li id="divider">
                  <hr class="dropdown-divider">
                </li>
                <li>
                  <a class="dropdown-item navi" href="/register">
                    <div class="d-flex flex-column">
                      <div class="d-flex justify-content-between align-items-center">
                        <span>Checkout</span>
                        <span class="format-float">` + subtotal + `</span>
                      </div>
                   

                      <div class="d-flex justify-content-between align-items-center">
                        <small>Eligible</small>
                        <small class="text-info">` + eligible_rank + `</small>
                      </div>

                      <div class="progress my-2" style="height: 4px;">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ` + perc + `%;" aria-valuenow="` + perc + `" aria-valuemin="0" aria-valuemax="100"></div>
                      </div>
                      <div class="row text-sm">
                        ` + bg_ranks2.join("") + `
                      </div>

                    
                    </div>
                  </a>
                </li>

              </ul>
            </div>
        `);
        });
        $("[minus-product-id]").each((i, v) => {
          var id = $(v).attr("minus-product-id");
          function minusItem() {
            commerceApp_.v(id);
            commerceApp_.components["updateCart"]();
          }
          $(v)[0].onclick = minusItem;
        });
        $("[delete-product-id]").each((i, v) => {
          var id = $(v).attr("delete-product-id");
          function deleteItem() {
            commerceApp_.q(id);
            commerceApp_.components["updateCart"]();
          }
          $(v)[0].onclick = deleteItem;
        });
        ColumnFormater.formatDate();
      },
      mcart() {
        var count = 0, list = [], subtotal = 0;
        subtotal = commerceApp_.g.map((v, i) => {
          return v.qty * v.retail_price;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        count = commerceApp_.g.map((v, i) => {
          return v.qty;
        }).reduce((a, b) => {
          return a + b;
        }, 0);
        commerceApp_.g.forEach((v, i) => {
          list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">
            <div style="width: 240px;" class="d-flex justify-content-between align-items-center">
              <span>` + v.name + `<br><small>(x` + v.qty + `)</small></span>
              <div class="d-flex align-items-center justify-content-between gap-2">
                <span class="font-sm format-float">` + (v.retail_price * v.qty).toFixed(2) + `</span>


              </div>
            </div>

          </a></li>

            `);
        });
        if (list.length == 0) {
          list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">Empty</a></li>

            `);
        }
        $("mcart").each((i, v) => {
          var needDropUp = `dropstart`;
          if ($(v).attr("dropup") != null) {
            needDropUp = `dropup`;
          }
          $(v).customHtml(`
            <div class="` + needDropUp + `  ">
              <div class="mx-3 py-2 btn btn-outline-danger rounded-xl position-relative"  data-bs-toggle="dropdown" aria-expanded="false">
                <div style="top: 4px !important;" class="badge bg-warning position-absolute top-0 start-100 translate-middle mbc">` + count + `</div>
                <i class="fa fa-shopping-cart"></i>
              </div>
              <ul class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start mac">
                ` + list.join("") + `
                <li id="divider">
                  <hr class="dropdown-divider">
                </li>
                <li>
                  <a class="dropdown-item navi" href="/merchant_checkout">
                    <div class="d-flex flex-column">
                      <div class="d-flex justify-content-between align-items-center">
                        <span>Checkout</span>
                        <span class="format-float">` + subtotal + `</span>
                      </div>
                    </div>
                  </a>
                </li>

              </ul>
            </div>
        `);
        });
        $("[minus-product-id]").each((i, v) => {
          var id = $(v).attr("minus-product-id");
          function minusItem() {
            commerceApp_.v(id, true);
            commerceApp_.components["updateMCart"]();
          }
          $(v)[0].onclick = minusItem;
        });
        $("[delete-product-id]").each((i, v) => {
          var id = $(v).attr("delete-product-id");
          function deleteItem() {
            commerceApp_.q(id, true);
            commerceApp_.components["updateMCart"]();
          }
          $(v)[0].onclick = deleteItem;
        });
        ColumnFormater.formatDate();
      },
      light() {
        $("light").customHtml(`
              <div class=" py-2 btn btn-outline-success rounded-xl position-relative light"  >
                <i class="fa fa-lightbulb far"></i>
              </div>
        `);
        $(".light").unbind();
        $(".light").on("click", () => {
          if ($("html").attr("data-bs-theme") == "light") {
            localStorage.setItem("data-bs-theme", "dark");
            $("html").attr("data-bs-theme", "dark");
          } else {
            localStorage.setItem("data-bs-theme", "light");
            $("html").attr("data-bs-theme", "light");
          }
        });
      },
      product() {
        $("product").customHtml(`
          <div class="text-center mt-4">
            <div class="spinner-border loading2" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
          </div>
            
        <div class="loading2 d-none" id="pcontent" />
        `);
        phxApp_.api("get_product", {
          id: pageParams.id
        }, null, (data2) => {
          $("title").html(data2.name);
          function addToCart_() {
            if (commerceApp_.first_cart_country_id == null && commerceApp_.f.length == 0) {
              commerceApp_.first_cart_country_id = phxApp_.e.id;
              console.log("first country id is " + phxApp_.e.id);
              localStorage.setItem("first_cart_country_id", phxApp_.e.id);
            }
            console.info(check);
            if (data2.countries.map((vv, ii) => {
              return vv.id;
            }).includes(parseInt(commerceApp_.first_cart_country_id))) {
              commerceApp_.k(data2);
              commerceApp_.components["updateCart"]();
              phxApp_.notify("Added " + data2.name, {
                delay: 2e3,
                type: "success",
                placement: {
                  from: "top",
                  align: "center"
                }
              });
              phxApp_.toast({
                content: `<div class=""><ul class="">` + $(".ac").html() + `</ul></div>`
              });
            } else if (commerceApp_.first_cart_country_id == null) {
              commerceApp_.k(data2);
              commerceApp_.components["updateCart"]();
              phxApp_.notify("Added " + data2.name, {
                delay: 2e3,
                type: "success",
                placement: {
                  from: "top",
                  align: "center"
                }
              });
              phxApp_.toast({
                content: `<div class=""><ul class="">` + $(".ac").html() + `</ul></div>`
              });
            } else {
              phxApp_.notify("Not Added ! Please choose your region products.", {
                delay: 2e3,
                type: "danger",
                placement: {
                  from: "top",
                  align: "center"
                }
              });
            }
          }
          $(".spinner-border.loading2").parent().remove();
          $(".loading2").removeClass("d-none");
          var img;
          if (data2.img_url != null) {
            try {
              img = data2.img_url;
            } catch (e) {
              img = "/images/placeholder.png";
            }
          }
          var rp = `<div class="font-sm fw-light text-secondary text-center ">RP <span class="format-float">` + data2.retail_price + `</span></div>`;
          if (phxApp_.e.name == "Malaysia") {
            includeShippingTax = false;
          } else {
            includeShippingTax = true;
          }
          if (includeShippingTax) {
            rp = `<div class="font-sm fw-light text-secondary text-center "><span class="format-float">` + data2.retail_price * 1.1 + ` </span> RP</div>`;
            if (phxApp_.e.name == "Singapore") {
              rp = `<div class="font-sm fw-light text-secondary text-center "><span class="format-float">` + data2.retail_price * 1.05 + ` </span> RP</div>`;
            }
            if (phxApp_.e.name == "China" && ["DT2\u4F53\u9A8C\u5361\u914D\u5957", "DT2\u542F\u52A8\u914D\u5957", "2\u5F2099\u6B21\u5F00\u673A\u5361 DT2\u542F\u52A8\u914D\u5957"].includes(data2.name)) {
              rp = `<div class="font-sm fw-light text-secondary text-center "><span class="format-float">` + data2.retail_price * 1 + ` </span> RP</div>`;
            }
          }
          if (!showRP) {
            rp = `<div class="font-sm fw-light text-secondary text-center ">MYR <span class="format-float">` + data2.retail_price * phxApp_.e.conversion + `</span></div>`;
            if (phxApp_.e.name == "Malaysia") {
              includeShippingTax = false;
            } else {
              includeShippingTax = true;
            }
            if (includeShippingTax) {
              rp = `<div class="font-sm fw-light text-secondary text-center ">MYR <span class="format-float">` + data2.retail_price * phxApp_.e.conversion * 1.1 + `</span></div>`;
              if (phxApp_.e.name == "Singapore") {
                rp = `<div class="font-sm fw-light text-secondary text-center ">MYR <span class="format-float">` + data2.retail_price * phxApp_.e.conversion * 1.05 + `</span></div>`;
              }
            }
          }
          addBtn = `<div class="btn btn-outline-primary mt-4" product-id="` + data2.id + `">Add</div>`;
          if (data2.instalment_packages.length > 0) {
            var cards = [];
            data2.instalment_packages.forEach((p2, i) => {
              c = `
              <div class=" col-12 col-lg-8 offset-lg-2 ">
                <div class="card m-4 p-4 ">
                  <div class="d-flex justify-content-between align-items-center">
                    <div class="fs-4">` + p2.name + `</div>
                    <span class="d-flex flex-column">
                      <div class="text-secondary">` + p2.retail_price + ` RP</div>
                      <div>` + p2.point_value + ` PV</div> 
                    </span>
                    <span><div class="btn btn-outline-primary" product-id="` + p2.id + `">Choose</div></span>
                  </div>
                </div>
              </div>

            `;
              cards.push(c);
            });
            addBtn = `<div class="row w-100">` + cards.join("") + `</div>`;
          }
          $("#pcontent").customHtml(`

        <div class="d-flex flex-column justify-content-center align-items-center ">
          <h2 id="ptitle">
          </h2>
              <div  class="d-flex justify-content-center p-4 " 
                  style="
                    position: relative; 
                    width: 320px;
                    height: 340px;">
              <div class="rounded py-2" style="
                    height: 340px;
                    width: 88%;
                    filter: blur(4px);
                    position: absolute;
                    background-repeat: no-repeat;
                    background-position: center;
                    background-size: cover;
                    background-image: url('` + img + `');
                    top: 30px;
                    left: 20px;
                    ">
              </div>
              <div class="rounded py-2" style="
                    height: 340px;
                    width:  100%;
                    z-index: 1;
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover; 
                    background-image: url('` + img + `');
                    ">
              </div>
            </div>
          <div style="margin-top: 50px;">` + data2.desc + `</div>
          ` + rp + `
          <div class="font-sm fw-light text-info text-center pv_label d-none">PV <span class="format-float">` + data2.point_value + `</span></div>
          ` + addBtn + `
        </div>

        `);
          $("#ptitle").html(
            data2.name
          );
          try {
            $("[product-id='" + data2.id + "']")[0].onclick = addToCart_;
          } catch (e) {
          }
        });
      },
      products() {
        function evalCountry2(countryName) {
          var prefix = "v2";
          if (countryName == "Thailand") {
            prefix = "th";
          }
          if (countryName == "Vietnam") {
            prefix = "vn";
          }
          if (countryName == "China") {
            prefix = "cn";
          }
          return prefix;
        }
        if (phxApp_.e == null) {
          var countries = [];
          phxApp_.j.forEach((v, i) => {
            countries.push(`
            <button type="button" aria-name="` + v.name + `" aria-country="` + v.id + `" class="btn btn-primary ">` + v.name + ` ` + (v.alias || "") + `</button>
          `);
          });
          phxApp_.modal({
            selector: "#mySubModal",
            content: `
          <center>
            <div class="btn-group-vertical">
            ` + countries.join("") + `
            </div>
          </center>
        `,
            header: "Choose region",
            autoClose: false
          });
          $("[aria-country]").unbind();
          $("[aria-country]").click(function() {
            var country_id = $(this).attr("aria-country"), name = $(this).attr("aria-name");
            phxApp_.e = country_id;
            phxApp_.notify("Chosen region: " + name);
            localStorage.setItem("region", name);
            setTimeout(() => {
              $("#chosen-region").html(name);
            }, 1e3);
            if (localStorage.region != null) {
              langPrefix = evalCountry2(name);
            }
            translationRes = phxApp_.api("translation", {
              lang: langPrefix
            });
            $("#mySubModal").modal("hide");
            commerceApp_.components["country"]();
            if (pageParams.share_code != null) {
              phxApp_.api("get_share_link_by_code", {
                code: pageParams.share_code
              }, null, (sponsor) => {
                commerceApp_.components["cartItems"]();
                phxApp_.navigateTo(location.pathname);
                $(".sponsor-name").customHtml("_sponsor: " + sponsor["user"]["username"] + " _position: " + sponsor.position);
                $(".sponsor-bank").html(`

              <div class="d-flex justify-content-between align-items-center">
                <span class="fw-bold">Bank Details</span>
                <span class=" my-4 me-4 d-flex justify-content-end align-items-end gap-1 flex-column">
                  <div>` + sponsor["user"]["bank_name"] + `</div>
                  <div>` + sponsor["user"]["bank_account_holder"] + `</div>
                  <div>` + sponsor["user"]["bank_account_no"] + `</div>
                </span>
              </div>

                `);
              });
            } else {
              phxApp_.navigateTo("/home");
            }
          });
        }
        if (phxApp_.e != null) {
          let addToCart2_ = function(dom) {
            var id = $(dom).attr("product-id");
            var data2 = phxApp_.api("get_product", {
              id
            });
            try {
              if (commerceApp_.first_cart_country_id == null && commerceApp_.f.length == 0) {
                commerceApp_.first_cart_country_id = phxApp_.e.id;
                console.log("first country id is " + phxApp_.e.id);
                localStorage.setItem("first_cart_country_id", phxApp_.e.id);
              }
              console.log(check);
              if (data2.countries.map((vv, ii) => {
                return vv.id;
              }).includes(parseInt(commerceApp_.first_cart_country_id))) {
                commerceApp_.selectedInstalment = data2;
                commerceApp_.k(data2);
                commerceApp_.components["updateCart"]();
                commerceApp_.components["cartItems"]();
                phxApp_.notify("Added " + data2.name, {
                  delay: 2e3,
                  type: "success",
                  placement: {
                    from: "top",
                    align: "center"
                  }
                });
              } else if (commerceApp_.first_cart_country_id == null) {
                commerceApp_.selectedInstalment = data2;
                commerceApp_.k(data2);
                commerceApp_.components["updateCart"]();
                commerceApp_.components["cartItems"]();
                phxApp_.notify("Added " + data2.name, {
                  delay: 2e3,
                  type: "success",
                  placement: {
                    from: "top",
                    align: "center"
                  }
                });
              } else {
                phxApp_.notify("Not Added ! Please choose your region products.", {
                  delay: 2e3,
                  type: "danger",
                  placement: {
                    from: "top",
                    align: "center"
                  }
                });
              }
            } catch (E) {
              console.error(E);
            }
          };
          $("products").each((i, products) => {
            $(products).customHtml(`
            <div class="text-center mt-4">
              <div class="spinner-border loading" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
            </div>
              

            <div class="row gx-0 d-none loading">
              <div class="col-12 col-lg-10 offset-lg-1">
                <div id="product_tab1"></div>
              </div>
            </div>
          `).then(() => {
              var customCols = null, random_id = "products", productSource = new phoenixModel({
                onDrawFn: () => {
                  setTimeout(() => {
                    $("[product-id]").each((i2, v) => {
                      v.onclick = () => {
                        addToCart2_(v);
                      };
                    });
                    ColumnFormater.formatDate();
                    $(".spinner-border.loading").parent().remove();
                    $(".loading").removeClass("d-none");
                  }, 800);
                },
                xcard: (params) => {
                  var data2 = params.product, showBtn = "", img = "/images/placeholder.png", onclickAttr = `onclick="phxApp.navigateTo('/products/` + data2.id + `/` + data2.name + `')"`;
                  if ($(products).attr("direct") != null) {
                    onclickAttr = "";
                    showBtn = `<div class="btn btn-outline-primary mt-4" product-id="` + data2.id + `">Add</div>`;
                  }
                  if (data2.img_url != null) {
                    try {
                      img = data2.img_url;
                    } catch (e) {
                      img = "/images/placeholder.png";
                    }
                  }
                  var rp = `<div class="font-sm fw-light text-secondary text-center ">RP <span class="format-float">` + data2.retail_price + `</span></div>`;
                  if (phxApp_.e.name == "Malaysia") {
                    includeShippingTax = false;
                  } else {
                    includeShippingTax = true;
                  }
                  if (includeShippingTax) {
                    rp = `<div class="font-sm fw-light text-secondary text-center "><span class="format-float">` + data2.retail_price * 1.1 + `</span> RP</div>`;
                    if (phxApp_.e.name == "Singapore") {
                      rp = `<div class="font-sm fw-light text-secondary text-center "><span class="format-float">` + data2.retail_price * 1.05 + `</span> RP</div>`;
                    }
                    if (phxApp_.e.name == "China" && ["DT2\u4F53\u9A8C\u5361\u914D\u5957", "DT2\u542F\u52A8\u914D\u5957", "2\u5F2099\u6B21\u5F00\u673A\u5361 DT2\u542F\u52A8\u914D\u5957"].includes(data2.name)) {
                      rp = `<div class="font-sm fw-light text-secondary text-center "><span class="format-float">` + data2.retail_price * 1 + `</span> RP</div>`;
                    }
                  }
                  if (!showRP) {
                    rp = `<div class="font-sm fw-light text-secondary text-center ">MYR <span class="format-float">` + data2.retail_price * phxApp_.e.conversion + `</span></div>`;
                    if (phxApp_.e.name == "Malaysia") {
                      includeShippingTax = false;
                    } else {
                      includeShippingTax = true;
                    }
                    if (includeShippingTax) {
                      rp = `<div class="font-sm fw-light text-secondary text-center ">MYR <span class="format-float">` + data2.retail_price * phxApp_.e.conversion * 1.1 + `</span></div>`;
                      if (phxApp_.e.name == "Singapore") {
                        rp = `<div class="font-sm fw-light text-secondary text-center ">MYR <span class="format-float">` + data2.retail_price * phxApp_.e.conversion * 1.05 + `</span></div>`;
                      }
                    }
                  }
                  var card = `
            <div  class="m-2 d-flex flex-column gap-2" ` + onclickAttr + `>
              <div  class="d-flex justify-content-center mb-4 py-4 background-p" 
                    style="
                      cursor: pointer;   
                      position: relative; "
                     >
                <div class="rounded py-2 background-p" style="
                  
                      width: 80%;
                      filter: blur(4px);
                      position: absolute;
                      background-repeat: no-repeat;
                      background-position: center;
                      background-size: cover;
                      background-image: url('` + img + `');
                      
                      ">
                </div>
                <div class="rounded py-2 foreground-p" style="
                     
                      width:  100%;
                      z-index: 1;
                      background-position: center;
                      background-repeat: no-repeat;
                      background-size: contain; 
                      background-image: url('` + img + `');
                      ">
                </div>
              </div>
              <div class="d-flex flex-column justify-content-center gap-2 mt-4">
                <div class="font-sm fw-bold text-center">` + data2.name + `</div>
                 <div class="d-flex flex-column justify-content-center ">
                    ` + rp + `
                    <div class="font-sm fw-light text-info text-center pv_label d-none">PV <span class="format-float">` + data2.point_value + `</span></div>
                 </div>
                 ` + showBtn + `

             
              </div>
            </div>
            `;
                  return card;
                },
                data: {
                  pageLength: 12,
                  sorts: [
                    [2, "desc"]
                  ],
                  additional_join_statements: [{
                    product: "product"
                    // product_country: "product_country",
                  }],
                  additional_search_queries: [
                    "b.is_instalment=false"
                  ],
                  country_id: phxApp_.e.id,
                  preloads: ["product"],
                  grid_class: "col-4 col-lg-3",
                  dom: `

                  <"row px-4"
                    <"col-lg-6 col-12"i>
                    <"col-12 col-lg-6">
                  >
                  <"row grid_view ">
                  <"list_view d-none"t>
                  <"row transform-75 px-4"
                    <"col-lg-6 col-12">
                    <"col-lg-6 col-12"p>
                  >

              `
                },
                columns: [
                  {
                    label: "id",
                    data: "id"
                  },
                  {
                    label: "product_id",
                    data: "product_id"
                  },
                  // {
                  //   label: 'retail_price',
                  //   data: 'retail_price'
                  // },
                  {
                    label: "Action",
                    data: "id"
                  }
                ],
                moduleName: "ProductCountry",
                link: "ProductCountry",
                customCols,
                buttons: [],
                tableSelector: "#" + random_id
              });
              productSource.load(random_id, "#product_tab1");
            });
          });
        }
      },
      announcement() {
        try {
          $(".anc").slick("destroy");
        } catch (e) {
        }
        $("announcement").customHtml(`
        <div class="spinner-border" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
        `);
        phxApp_.api("announcements", {}, null, (list) => {
          $("announcement").customHtml(``);
          list.forEach((v, i) => {
            function showContent() {
              phxApp_.modal({
                selector: "#mySubModal",
                content: v.content,
                autoClose: false,
                header: v.title
              });
            }
            var url = v.img_url, doc = `
            <div class="d-flex flex-column align-items-center" >

              <div class="d-flex justify-content-center " style="cursor: pointer;   
              position: relative; height: 240px;" announcement-id="` + v.id + `">
                <div class="sub rounded py-2" style="
                 
                    position: absolute;
                    filter: blur(10px); 
                                background-repeat: no-repeat;
                    background-position: center;
                    background-size: contain; 
                    background-image: url('` + url + `');
                   ">
                </div>
                <div class="su rounded py-2" style="
              
             

                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover; 
                    background-image: url('` + url + `');
                    z-index: 1;
                    top: 16px;
                    position: absolute;">
                </div>
              </div>
              <span class="mt-3">` + v.title + `</span>
              <small>` + v.subtitle + `</small>
              
            </div>

          `;
            $("announcement").append(doc);
            $("[announcement-id='" + v.id + "']")[0].onclick = showContent;
          });
        });
        $(".anc").slick();
      },
      rewardList() {
        $("rewardList").each((rii, v) => {
          $(v).customHtml(`
          <div class="text-center mt-4">
            <div class="spinner-border loading" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
          </div>
            

          <div class="row gx-0 d-none loading">
            <div class="col-12">
              <div id="tab` + rii + `">No rewards</div>
            </div>
          </div>
        `);
          var isPrev = $(v).attr("prev") != null;
          console.log(isPrev);
          phxApp_.api("get_reward_summary", {
            user_id: memberApp_.user.id,
            is_prev: isPrev
          }, null, (r) => {
            $(".spinner-border.loading").parent().remove();
            $(".loading").removeClass("d-none");
            var rewards = [
              "sharing bonus",
              "team bonus",
              "matching bonus",
              "elite leader",
              "travel fund",
              "repurchase bonus",
              "drp sales level bonus",
              "stockist register bonus",
              "merchant sales level bonus",
              "biz incentive bonus",
              "matching biz incentive bonus"
              // "royalty bonus"
            ], list = [];
            rewards.forEach((r2, ii) => {
              r.forEach((v2, i) => {
                if (r2 == v2.name) {
                  list.push(`

                                    <div class="my-2 d-flex align-items-center justify-content-between">

                                      <span class="fs-5">
                                        ` + ColumnFormater.capitalize(v2.name) + `
                                      </span>
                                      <span class="d-flex justify-content-between gap-2 align-items-center">
                                        <span class="format-float">
                                          ` + v2.sum + `
                                        </span>
                                        <a href="/reward_details/` + v2.name + `/` + v2.period[0] + `/` + v2.period[1] + `" class="navi btn btn-primary btn-sm">
                                        <i class="fa fa-info"></i>
                                        </a>
                                      </span>
                                    </div>


                                `);
                }
              });
            });
            $("#tab" + rii).customHtml(`` + list.join(""));
            phxApp.formatDate();
          });
        });
      },
      rewardSummary() {
        $("rewardSummary").each((rii, v) => {
          $(v).customHtml(`
                      <div class="text-center mt-4">
                        <div class="spinner-border loading" role="status">
                          <span class="visually-hidden">Loading...</span>
                        </div>
                      </div>
                        

                      <div class="row gx-0 d-none loading">
                        <div class="col-12">
                          <div id="tabw` + rii + `">No rewards</div>
                        </div>
                      </div>
                    `);
          var isPrev = false;
          console.log(isPrev);
          phxApp_.api("get_reward_summary_by_years", {
            user_id: memberApp_.user.id
          }, null, (r) => {
            var list = [];
            $(".spinner-border.loading").parent().remove();
            $(".loading").removeClass("d-none");
            console.log("testst");
            var years = Object.keys(r["years"]);
            years.forEach((v2, i) => {
              list.push(`

                                    <div class="my-2 d-flex align-items-center justify-content-between">

                                      <span class="fs-5">
                                        ` + v2 + `
                                      </span>
                                      <span class="d-flex justify-content-between gap-2 align-items-center">
                                        <div>
                                        <span class="format-float">
                                          ` + r["years"][v2][0].sum + ` 
                                        </span>
                                        BP
                                          </div>
                                          <a class="btn btn-primary btn-sm" target="_blank" href="/pdf?type=commission&id=` + memberApp_.user.id + `&year=` + v2 + `">
                                          Download
                                        </a>
                                      </span>
                                    </div>


                                `);
            });
            console.info(list);
            $("#tabw" + rii).customHtml(`` + list.join(""));
            phxApp.formatDate();
          });
        });
      },
      wallet() {
        if (memberApp_.user != null) {
          var user = memberApp_.user, wallets = phxApp_.api("user_wallet", {
            token: user.token
          });
          if (wallets.length == 0) {
            $("wallet").parent().customHtml(`<div class="p-4">Wallet info expired</div>`);
          } else {
            $("wallet").each((i, v) => {
              var check2 = wallets.filter((wv, wi) => {
                return wv.wallet_type == $(v).attr("aria-data");
              });
              if (check2.length > 0) {
                var wallet = check2[0];
                var wallet_name = $(v).attr("aria-data").split("_").map((v2, i2) => {
                  return ColumnFormater.capitalize(v2);
                }).join(" ");
                var short_name = wallet_name.split(" ").map((i2, v2) => {
                  return i2.split("")[0].toUpperCase();
                }).join("") + "P";
                $(v).customHtml(`
              <a href="/wallets/` + wallet.id + `" class="navi" >

              <div class=" card mb-3 mb-lg-0">
                <div style="
                  width: 4px;
                  position: absolute;
                  height: 100%;
                  background: rgb(251,254,253);
                  background: linear-gradient(45deg, rgb(86, 253, 197) 0%, rgb(218, 216, 216) 100%);

                " class="card-body p-0 "></div>
                <div class="card-body p-1 py-2 " style="width: 220px;">
                  <div class="d-flex gap-1 align-items-center">
                    <div wallet-id="` + wallet.id + `" class="d-none d-lg-block mx-2 py-2 btn btn-outline-success rounded-xl">
                      <i class=" fa fa-dollar-sign "></i>
                    </div>
                    <div class="ps-2 ps-lg-0">
                      <span class="text-sm text-secondary text-truncate">` + wallet_name + `, <b>` + short_name + `</b></span>
                      <div class="d-flex align-items-center gap-2">
                        <div class="fs-4 format-int" style="">` + wallet.total + `</div>
                        <small>pts</small>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="card-body p-0 d-none" style="

                  background: rgb(251,254,253);
                  background: linear-gradient(90deg, rgb(86, 253, 197) 0%, rgb(218, 216, 216) 100%);
                  height: 2px;

                "></div>
              </div>
              </a>

          `);
              } else {
              }
            });
          }
          ColumnFormater.formatDate();
        }
      },
      userProfile() {
        var user = memberApp_.user;
        if (user) {
          var ranks = ["Bronze Package", "Silver Package", "Gold Package", "Shopper", "PreferredShopper"], cranks = ["\u94DC\u7EA7\u5957\u9910", "\u94F6\u7EA7\u5957\u9910", "\u91D1\u7EA7\u5957\u9910", "Shopper", "PreferredShopper"], rank_name = user.rank != null ? user.rank.name : user.rank_name;
          var display_rank = ranks[cranks.indexOf(rank_name)];
          if (phxApp_.e.name == "China") {
            display_rank = rank_name;
          }
          var name = user != null ? `Welcome! <a href="/profile" class="navi">` + user.fullname + ` (` + display_rank + `)</a>` : `<a href="/login" class="navi">Login</a>`;
          $("userProfile").customHtml(`
            
              ` + name + `
           
        `);
        } else {
          $("userProfile").customHtml(`
            
            <a href="/login" class="navi">Login</a>
           
        `);
        }
      }
    }
  };

  // assets/js/app.js
  var import_phoenix = __toESM(require_phoenix());
  $("html").attr("data-bs-theme", localStorage.getItem("data-bs-theme"));
  window.showRP = true;
  window.includeShippingTax = true;
  window.toggleMcart = false;
  var useSw = false;
  var isDev = window.location.hostname == "localhost";
  if (isDev) {
    useSw = false;
  }
  if ("serviceWorker" in navigator && useSw) {
    navigator.serviceWorker.register("/sw.js").then((registration) => {
      console.log("Service Worker registered with scope:", registration.scope);
    }).catch((error2) => {
      console.error("Service Worker registration failed:", error2);
    });
  }
  var langPrefix2 = "v2";
  window.translationRes = "";
  function evalCountry(countryName) {
    var prefix = "v2";
    if (countryName == "Thailand") {
      prefix = "th";
    }
    if (countryName == "Vietnam") {
      prefix = "vn";
    }
    if (countryName == "China") {
      prefix = "cn";
    }
    return prefix;
  }
  try {
    if (localStorage.region != null) {
      langPrefix2 = evalCountry(localStorage.region);
    }
    translationRes = phxApp_.api("translation", { lang: langPrefix2 });
  } catch (error2) {
    console.error("Error fetching translation:", error2);
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
  window.phoenixModels = [];
  window.phxApp = phxApp_;
  phxApp_.api("countries", {}, null, (e) => {
    window.countries = e;
    phxApp_.j = e;
  });
  if (isDev) {
    window.commerceApp = commerceApp_;
    window.memberApp = memberApp_;
  }
  window.addEventListener(
    "popstate",
    function(event) {
      try {
        if (history.valueOf().state != null) {
          window.back = true;
          window.parsePage = true;
          phxApp.navigateTo(history.valueOf().state.route);
        } else {
          phxApp.notify("cant back");
          phxApp.navigateTo("/home");
        }
      } catch (e) {
        console.log("!");
      }
    },
    true
  );
  var route_list = [
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
    { html: "gs_summary.html", title: "Group Sales", route: "/group_sales" }
  ];
  route_list.forEach((v, i) => {
    phxApp_.route_names.push(v);
  });
  phxApp_.navigateTo();
  var socket = new import_phoenix.Socket("/socket", { params: { token: window.userToken } });
  window.socket = socket;
  socket.connect();
  $(document).on("click", "a.navi", function(event) {
    phxApp.show();
    event.preventDefault();
    setTimeout(() => {
      if ($(this).attr("href").includes("#")) {
      } else {
        phxApp_.navigateTo($(this).attr("href"));
      }
    }, 200);
  });
})();
/*!
  * Bootstrap v5.3.2 (https://getbootstrap.com/)
  * Copyright 2011-2023 The Bootstrap Authors (https://github.com/twbs/bootstrap/graphs/contributors)
  * Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)
  */
