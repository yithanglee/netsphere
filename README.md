## Frontend Architecture (Vite + Phoenix)

### Overview
- The Vite app uses a lightweight, custom router defined in `vite_front/src/main.js` (`route_list`).
- Pages are plain static HTML files served by Phoenix from `netsphere/priv/static/html/v2/*.html`.
- Navigation calls `phxApp_.html(page)` to fetch and inject the static HTML into `#content`.
- Static HTML can contain custom elements (e.g., `<products></products>`). After navigation, `commerceApp_.render()` scans the DOM and executes matching component functions to populate those elements.

### Key files
- `vite_front/src/main.js`: Registers routes and boots the app (calls `phxApp_.navigateTo()` on load).
- `vite_front/src/phx_app.js`:
  - Exposes config via Vite envs: `VITE_PHX_ENDPOINT`, `VITE_PHX_HTTP_PROTOCOL`, `VITE_PHX_WS_PROTOCOL`, `VITE_PHX_COOKIE`.
  - `html(page)`: synchronously fetches Phoenix static HTML: `${PHX_HTTP_PROTOCOL}${PHX_ENDPOINT}/html/<lang>/<page>`.
  - `navigateTo(route)`: resolves route → loads nav + page HTML → calls `navigateCallback()`.
  - `navigateCallback()`: restores user/cart, calls `commerceApp_.render()`, formats UI.
  - HTTP helpers: `api(scope, params, ...)` (GET), `post(scope, params, ...)` (POST), `form(...)`, `modal(...)`, `toast(...)`, `notify(...)`.
- `vite_front/src/commerce_app.js`:
  - Manages cart state, product listing, and page widgets.
  - `render()`: finds custom tags and invokes the component with the same name to populate them (e.g., `<products>` → `components.products()`).
  - `components`: collection of functions, one per custom element (e.g., `products`, `product`, `cartItems`, etc.).
- Static pages: `netsphere/priv/static/html/v2/*.html` (e.g., `landing.html` includes `<products></products>`).

### Routing flow
1. `route_list` in `vite_front/src/main.js` holds `{ html, title, route, [public], [skipNav] }` entries.
2. `phxApp_.navigateTo("/path")` matches a route, loads nav + `html`, sets `<title>`, updates history.
3. `navigateCallback()` runs, which calls `commerceApp_.render()`.
4. `commerceApp_.render()` looks for matching custom elements and renders components into them.

Example route entry in `vite_front/src/main.js`:
```js
{ html: "landing.html", title: "Home", route: "/home", public: true }
```

`phx_app.js` HTML fetcher (simplified):
```js
html(page) {
  const url = this.endpoint + "/html/" + langPrefix + "/" + page;
  let res = "";
  $.ajax({ async: false, method: "get", url }).done(j => { res = j; });
  return res;
}
```

### Components and custom elements
- In any static HTML, you can declare a custom tag and provide a component function with the same name under `commerceApp_.components`.
- After each navigation, `commerceApp_.render()` runs and populates all discovered tags.

Example (`netsphere/priv/static/html/v2/landing.html`):
```html
<section>
  <div class="container p-4">
    <div class="d-flex flex-column align-items-center justify-content-center mt-4">
      <span class="text-sm text-primary">New Arrivals</span>
      <div class="fs-2 fw-bold border-bottom border-5 border-success">Products</div>
    </div>
    <products></products>
  </div>
  <!-- The <products> tag will be rendered by commerceApp_.components.products() -->
  
</section>
```

Example component (`vite_front/src/commerce_app.js`):
```js
components: {
  products() {
    $("products").customHtml(`...loading markup...`).then(() => {
      // Fetch and render your product grid/list
    });
  }
}
```

### Add a new page (step-by-step)
1) Create the static HTML file under `netsphere/priv/static/html/v2/`, e.g. `about.html`.
   - Optionally add custom elements like `<aboutContent></aboutContent>`.

2) Add a component in `vite_front/src/commerce_app.js` matching your custom tag:
```js
components: {
  aboutContent() {
    $("aboutContent").customHtml(`<div class="p-4">About content here</div>`);
  }
}
```

3) Register the route in `vite_front/src/main.js` `addRoutes()`:
```js
{ html: "about.html", title: "About", route: "/about", public: true }
```

4) Navigate to the route (e.g., clicking a link with class `navi` or calling `phxApp_.navigateTo('/about')`).

### Calling backend APIs
- Use `phxApp_.api(scope, params, failedCb?, successCb?)` for GETs to `/svt_api/webhook?scope=<scope>`.
- Use `phxApp_.post(scope, params, failedCb?, successCb?)` for POSTs to the same webhook endpoint.
- For CRUD on modules, `phxApp_.createForm()` and related helpers generate forms and submit to `/svt_api/<ModuleName>`.
- CSRF tokens are handled via `phxApp_.csrf_()` and injected where needed.

### Environment variables (Vite)
Define these in your Vite environment (.env, .env.local, etc.):
```bash
VITE_PHX_ENDPOINT=your-phoenix-hostname:4000
VITE_PHX_HTTP_PROTOCOL=http://
VITE_PHX_WS_PROTOCOL=ws://
VITE_PHX_COOKIE=phx_session
```
`phx_app.js` builds `phxApp_.endpoint = VITE_PHX_HTTP_PROTOCOL + VITE_PHX_ENDPOINT`.

### Run the app
- Phoenix (from `netsphere/`):
  - `mix deps.get`
  - `mix phx.server`
- Vite frontend (from `vite_front/`):
  - Install dependencies and run your usual Vite dev/build scripts (ensure env vars above are set). The frontend will query the Phoenix endpoint configured by the Vite envs.

### Troubleshooting
- If a page shows but custom elements remain empty, ensure:
  - The custom tag exactly matches a function name under `commerceApp_.components`.
  - `commerceApp_.render()` is called (it runs from `phxApp_.navigateCallback()`).
  - The static HTML filename exists under `netsphere/priv/static/html/v2/` and is referenced in the route.
  - Vite envs point to the correct Phoenix host and scheme.

---

# CommerceFront

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

1RP/BP=Rm5
RB=Register Point 
BP=Bonus Point
DRP=Direct Recruitment Point

Bronze Package > RP100｜50PV
Silver Package > RP400｜200PV
Gold Package > RP1000｜500PV

A) Sharing Bonus 40%
Bronze -G1-20%
Silver -G1-20%,G2-10%
Gold -G1-20%,G2-10%,G3-10%

A.2）Special Sharing Reward
For every 100PV shared, receive an additional #DRP 50
#DRP only for registering new shared entries, PV not included.
When choosing DRP at registration, you only need to pay the balance of RP 50%.


i buy bronze package , 100 RP
when choose pay with DRP,
i can only use 50 RP?
can use less?


B）Team Bonus-weak team 10%(MPO40%)
Bronze-daily max BP100
Silver-daily max BP500
Gold-daily max BP1500

C）Matching Bonus 30%(Match TB only ,MPO12%)
Ever month weak team pv achieved 
500PV qualified G1-10% 
1,000PV qualified G1-10%+G2-10% 
1,500PV qualified G1-10%+G2-10%+G3-10% 

D）Elite Leader CTO sharing 5%
Ever month weak team pv achieved 
1,500PV-1star-1%
3,000PV-2stars-1%+1%
10,000PV-3stars-1%+1%+1%
30,000PV-4stars-1%+1%+1%+1%
50,000PV-5stars-1%+1%+1%+1%+1%

E）Travel Fund 5%
Ever month weak team pv achieved 
1,500PV-1pt
3,000PV-3pts
5,000PV-6pts

F）mobile stockist fee 3%
Purchase products RP 2000 | 1000PV become mobile stockist ，
Get 3 business centre U1,U2 & U3
& Get extra DRP 1000

E) Repurchase Bonus 50% (on new sales ) Automatically deducts 10% from B, C & D bonuses,
Up to a maximum deduction of BP1000 per month (which means the bonus has reached BP10000). 1000 goes into the Product point wallet for product exchanges.

Monthly weak team performance reaches 500PV
Qualify to enjoy 20 levels x 2.5%

———————
remark：
RB whidrawal charge 3% .


1RP/BP=Rm5
RB=注册积分
BP=奖励积分
DRP=直推积分

青铜套餐 > RP100｜50PV
银色套餐 > RP400｜200PV
黄金套餐 > RP1000｜500PV

A) 分享奖金40%
青铜-G1-20%
银-G1-20%,G2-10%
黄金-G1-20%，G2-10%，G3-10%
compress upline 

A.2）特别分享奖励
每分享 100PV，即可获得额外的 #DRP 50
#DRP仅用于注册新的分享套餐，不含PV。
注册时选择DRP（Direct Recruitment Points）时，只需支付RP（Register Points）余额的50%即可。

B）团队奖金-小区10%(MPO40%)
青铜级-每日最高BP100
白银-每日最高BP500
黄金-每日最高BP1500

C）领导奖金30%（仅计团队奖金,MPO12%）
小区每月pv达到
500PV合格G1-10%
1,000PV合格G1-10%+G2-10%
1,500PV合格G1-10%+G2-10%+G3-10%

D）精英领袖CTO分享5%
小区每月pv达到
1,500PV-1星-1%
3,000PV-2星-1%+1%
10,000PV-3星-1%+1%+1%
30,000PV-4星-1%+1%+1%+1%
50,000PV-5星-1%+1%+1%+1%+1%

E）旅游基金5%
小区每月pv达到
1,500PV-1点
3,000PV-3点
5,000PV-6点

F）流动配货商服务费3%
购买产品 RP 2000 | 1000PV
获得3个商务中心U1、U2和U3
& 获得额外 DRP 1000

E) 复消奖 50%（新业绩）
自动从 B、C 和 D 奖金中扣除 10%，
每月最多扣除 BP1000（这意味着奖金已达到 BP10000）。 
1000 复消进入产品钱包用于产品交换。

小区每月pv达到500PV
有资格享受20层x 2.5%


need a redemption area,
the product retail_price is the same rate as product wallet point,
say i have 100 product wallet point, 
if the product A is $ 120, i need 100 product wallet point + 20 register point (auto deduct bonus if RP not enough)

those product wallet if accumulated 6 months without any order, will auto purchase and send to customer...
the 1st month product wallet will go out first,
FIFO method...

——————
⚠️注意：
BP提款手续费3%


when register
can choose register point 
if not enough register topup with bonus point

admin need to be able to register account without payment

within 6 month when upgrade can pay partial/balance
after that need full amount to upgrade



23/11
DRP sales level bonus 10 %
placement tree upline 10 levels

context = after register 2 user, you get DRP,
when use DRP register , this will calculate only the DRP sales level bonus

+ let admin create free accounts.

----

 - the drp sales level need push 1 level up [done]
 - check the daily team balance [done]

----
  + stockist 3 % [done]

  + shopper, if havent reach bronze, still can have account, just a shopper, still need placement for parking,
  but no commission
  but can upgrade to bronze and become placement [done]

  + bonus point can covert to register point only [done]
  
 - pay into travel fund wallet, need to check company company total PV * 0.05
  -- company 100k PV, = 5000 PV
  -- check how many ppl collected the travel fund shares, if everyone has 500 share 
  -- 5000 / 500 = 10 travel fund point , 
  -- pay into TF wallet, use the total share x this 10 travel fund point; [done]
  + DRP option [done]
  + RP can transfer to upline  [done]
  + redeem point need at least 500 RP, else charge 2 RP as shipping fee [done]
    + admin pay button [done]
 + DO and customer order PDF  [done]
  + sales performance summary by country  [done]
+ the invoice display subtotal rename the discount to only DRP [done]

+ accumulate order to upgrade 180 days [done]
+ when upgrade can use DRP as well [done]
 * pls check direct sponsor and only downline (esp level 1 referal downline) [done]

!! need to ensure the balance of the reward allocations  [done]
 
+  referal group sales...[done]
+ royalty bonus  [done]
  - only pay to  RP wallet
  - monthly calculation
  - referal group sales to calculate 
  - put the royalty percentage in the user list
  - royalty_users 


+ for sabah sarwk < 200RP + 4RP shippping 
< 400RP + 8RP   
every  200 RP charge - 4RP [done]
+ admin to modify ranking...[done]
+ admin give free DRP [done]
1 account approve button hide after approve [done]
3 ref no = DRP + RP [done]
4 customer order if upgrade show user [done]
9 DO add username [done]

5 multi language[done]
1 to withdraw/convert must key in IC no and DOB [done]
8 DO ref no when mark sent [done]
b1 admin create self pick up points [done] 
b2 user choose self pick up [done]


--
*OUTSTANDING*

+ pay a lump instead of detail lines for royalty bonus
+ Travel fund need to cap per month 60 share
+ then recalculate the share per unit value


sales page to include paid amount
ewallet page to filter by wallet types
dashboard to show sales that's not cancelled


00 send link to register + add products
0 username cant modify by member
1b withdraw bank account holder name must follow IC name
2 DRP sales item line show as 0pv
6 set combo items
7 admin auto convert stockist 
b3 multiple country shipping fee 
b4 inventory logging - 2 MD
b5 inventory audit - FOC
10 admin side menu


--
  + admin storekeeper , need to view sales by country
  + admin storekeeper need to print by date, country,
  + inventory with stock keeping transaction for store keeper 



  ----


  merchant mall


  100 RP merchant product



  merchant point 50% max

  register point 50% min





   based on received RP to collect the platofrm fee
   collected RP 10% to payout commission






30% / 5
20% / 5

4%
4%
4%
4%
4%



10% / 5

   2%
   2%
   2%
   2%
   2%


   merchant product can set min 10% as commission 


   100 RP 



register  form
add nationality * compolosry [v]
add residence address
delviery method : send to addres


foreigners need deduct 10% as foregiener income tax

when  update rp remarks, ensure the is_approved mark is checked [v]


---

todo
[v] merchant mall add merchant label
[v] modify the customer order into invoice
[v] update the merchant application TnC
[v] add commission perc

----

todo 22/feb

[v] override login
[v] U2,U3 rewward list view by U1
[v] when pay reward, pay to U1
admin sales filter by country
merchant product filter by business category

----

http://staging.haho2u.com/
http://test_svt.damienslab.com/




--

1 register page add the function to search for their downline  
then insert into the input [v]
2 when navigate the placement tree, add the function to search by username ( only own tree) [v]

3 the register page, remove the default values. [v]
4 



---

23/5

pdf invoice 
1. replace the pamynet by method, with sales person name






maintain bonus


before month end, personal purchase at least 36RP,
personal sponsor 2 ppl = 11 level
4 ppl = 22 level


----

withdrawl add another 2nd pw

instalment packs every month has different stock to deduct


registration sequence to change,
the sponsor detail first,
then the payment
then the shipping details



admin to assist the sponsor to 
pay the instalment

if the sponsor has sufficient DRP,
will proceed to use the DRP first to make the payment



----


 + admin help pay, also need ensure there's address
 + instalment payment need to include the shipping address 
 + shipping fee 0 for those instalment payments 



----

CN增加一个
DT2 Topup Card配套
10张卡
375RP｜PV 0｜BV375


shipping fee = 0 !  [v]

投放奖15% [v]
direct payout !  [v]

帮扶奖第一代50% [v]
帮扶奖第二代50%[v]
need admin approve payout  [v]


帮扶奖：以投放奖的来计算
total payout: 30% on BV
should not payout the DRP bonus, cannot use DRP to pay for registration 


admin sponsor pay cant use drp ! [v]


stockist fee need to specify [v]
sponsor tree [v]


the instalment packge need a delay, bcuz china allow use to try 90 days  [v]

need a contract view ? optional


to be used for the topup card pacakges

----