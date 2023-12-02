import {
  ColumnFormater
} from './column_formatter.js';

import {
  memberApp_
} from './member_app.js';
import {
  phxApp_
} from './phx_app.js';

import {
  phoenixModel
} from './phoenixModel.js';
export let commerceApp_ = {
  cart_: [],
  emptyCart_() {
    this.cart_ = []
    localStorage.setItem("cart", JSON.stringify(this.cart_))
  },
  restoreCart() {
    if (localStorage.getItem("cart") != null) {
      this.cart_ = JSON.parse(localStorage.getItem("cart"));
    }


  },
  hasCartItems() {
    return this.cart_.length
  },
  addItem_(item) {

    var searchObject = item;

    var index = this.cart_.findIndex(item => item.id === searchObject.id);

    if (index >= 0) {

      var foundItem = this.cart_[index]
      foundItem.qty += 1

    } else {
      item.qty = 1
      this.cart_ = [item, ...this.cart_]

    }


    localStorage.setItem("cart", JSON.stringify(this.cart_))

  },
  addItemById_(id) {


    var index = this.cart_.findIndex(item => item.id == parseInt(id));

    if (index >= 0) {

      var foundItem = this.cart_[index]
      phxApp_.notify("item " + foundItem.name + " added !", {
        delay: 2000,
        type: "success",
        placement: {
          from: "top",
          align: "center"
        }
      })
      foundItem.qty += 1




    } else {
      // item.qty = 1
      // this.cart_ = [item, ...this.cart_]

    }



    localStorage.setItem("cart", JSON.stringify(this.cart_))

  },
  minusItem_(id) {


    var index = this.cart_.findIndex(item => item.id == parseInt(id));

    if (index >= 0) {

      var foundItem = this.cart_[index]
      phxApp_.notify("item " + foundItem.name + " deducted !", {
        delay: 2000,
        type: "success",
        placement: {
          from: "top",
          align: "center"
        }
      })
      foundItem.qty -= 1

      if (foundItem.qty == 0) {
        this.removeItem_(id)
      }


    } else {
      // item.qty = 1
      // this.cart_ = [item, ...this.cart_]

    }


    localStorage.setItem("cart", JSON.stringify(this.cart_))

  },
  removeItem_(id) {
    var index = this.cart_.findIndex(item => item.id == parseInt(id));
    var foundItem = this.cart_[index]

    phxApp_.notify("item " + foundItem.name + " removed !", {
      delay: 2000,
      type: "warning",
      placement: {
        from: "top",
        align: "center"
      }
    })

    var removed = this.cart_.splice(index, 1)
    localStorage.setItem("cart", JSON.stringify(this.cart_))

  },
  toastChanges() {
    phxApp_.toast({ content: `<div class=""><ul class="">` + $(".ac").html() + `</ul></div>` })
  },
  total_() {
    var amount = this.cart_.map((v, i) => {
      return v.price
    }).reduce((a, b) => {
      return a + b
    })
    return amount
  },
  render() {
    // this find all all the related components on the page and transform them.
    // has to be done after rendering page, 
    // callback function to call this render
    var list = ["userProfile", "wallet", "announcement", "products", "product",
      "rewardList", "cart", "cartItems", "salesItems"
    ]

    list.forEach((v, i) => {

      if ($(v).length > 0) {
        try {
          this.components[v]()
        } catch (e) {
          console.log(error)
        }
      }
    })
  },
  components: {
    salesItems() {


      var sale = phxApp_.api("get_sale", { id: pageParams.id })

      if (sale.status == "pending_payment") {
        var res = phxApp_.api("check_bill", { id: sale.payment.billplz_code })

        if (res.paid == true) {
          phxApp_.notify("Payment updated!")
        }
      }
      $("title").html("Order ID: " + sale.id)
      window.sale = sale
      var count = 0,
        list = [],
        total_pv = 0,
        subtotal = 0.0;
      total_pv = sale.sales_items.map((v, i) => {
        return (v.qty * v.item_pv)
      }).reduce((a, b) => {
        return a + b
      }, 0)
      subtotal = sale.sales_items.map((v, i) => {
        return (v.qty * v.item_price)
      }).reduce((a, b) => {
        return a + b
      }, 0)
      count = sale.sales_items.map((v, i) => {
        return v.qty
      }).reduce((a, b) => {
        return a + b
      }, 0)



      eligible_rank = this.evalRank(subtotal)



      sale.sales_items.forEach((v, i) => {
        var img = '/images/placeholder.png';
        if (v.img_url != null) {

          try {
            img = v.img_url
          } catch (e) {
            img = '/images/placeholder.png'
          }
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
                <span>` + v.item_name + ` <small>(x` + v.qty + `)</small></span>
              </div>
              <div class="d-flex flex-column flex-lg-row justify-content-between align-items-center">
                <div class="d-flex flex-column align-items-end">
                  <span class="font-sm ">RP <span class="format-float">` + (v.item_price * v.qty).toFixed(2) + `</span></span>
                  <span class="font-sm text-info format-integer">` + (v.item_pv * v.qty) + ` PV</span>
                </div>
               
              </div>
            </div>

          
            `)


      })


      var payment_info = `

               <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-4">Subtotal</span>
                  <span class=" me-4">RP <span class="format-float">` + subtotal + `</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-5">Total PV</span>
                  <span class="text-info me-4"><span class="format-integer">` + total_pv + ` PV</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fw-bold text-secondary">Eligible Rank</span>
                  <span class="text-info me-4"><span class="format-integer">` + eligible_rank + `</span></span>
                </div>

      `

      reg_dets = JSON.parse(sale.registration_details)
      shipping = reg_dets.user.shipping
      payment = sale.payment
      var drp_details = {};
      if (sale.payment.payment_url != null) {
        payment_info = `

               <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-4">Subtotal</span>
                  <span class=" ">RP <span class="format-float">` + subtotal + `</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-5">Total PV</span>
                  <span class="text-info "><span class="format-integer">` + total_pv + ` PV</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fw-bold text-secondary">Eligible Rank</span>
                  <span class="text-info "><span class="format-integer">` + eligible_rank + `</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fw-bold text-secondary">Paid with</span>
                  <span class="text-primary "><span class="">` + (payment.payment_method.split("_").map((v, i) => {
          return ColumnFormater.capitalize(v)

        }).join(" ")) + `</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fw-bold text-secondary">Payment Link</span>
                  <span class="text-primary "><a target="_blank" href="` + payment.payment_url + `" class="">` + payment.payment_url + `</a></span>
                </div>

      `
      }
      if (sale.payment.webhook_details != null) {

        sale.payment.webhook_details.split("|").map((v, i) => {

          data = v.split(": ")
          var key = data[0].replace(" ", "_")
          console.log(key)
          drp_details[key] = parseFloat(data[1])


        })
        drp_amount = 0
        if (drp_details.drp_paid != null) {

          drp_amount = drp_details.drp_paid
        }
        if (drp_details.pp_paid != null) {
          total_pv = 0
        }
        payment_info = `

               <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-5">Subtotal</span>
                  <span class=" ">RP <span class="format-float">` + subtotal + `</span></span>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-5">Discount (<small>DRP</small>)</span>
                  <span class=" ">- RP <span class="format-float">` + drp_amount + `</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-5">Total PV</span>
                  <span class="text-info "><span class="format-integer">` + (total_pv - drp_amount ) + ` PV</span></span>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                  <span class="fs-4">Grand Total</span>
                  <span class=" ">RP <span class="format-float">` + (subtotal - drp_amount - (drp_details.rp_paid||0)) + ` PV</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fw-bold text-secondary">Eligible Rank</span>
                  <span class="text-info "><span class="format-integer">` + eligible_rank + `</span></span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="fw-bold text-secondary">Paid with</span>
                  <span class="text-primary "><span class="">` + (payment.payment_method.split("_").map((v, i) => {
          return ColumnFormater.capitalize(v)

        }).join(" ")) + `</span></span>
                        </div>

              `


      }




      $("salesItems").html(`
        <div class="d-flex align-items-center justify-content-between gap-2">
          <h2>Sales Details</h2><small class="badge bg-primary">` + sale.status + `</small>
        </div>
                <div class="d-flex flex-column mb-4 ">
                   <span class="text-secondary">Recipient:</span> 
                   <span>` + (reg_dets.user.fullname || phxApp_.user.fullname )+ `, ` + (reg_dets.user.phone || phxApp_.user.phone) + `</span>
                   <span>` + (reg_dets.user.email || phxApp_.user.email )+ ` </span>
                </div>


                <div class="d-flex flex-column mb-4 ">
                   <span class="text-secondary">Deliver To:</span> 
                   <span>` + shipping.line1 + `, ` + shipping.line2 + `</span>
                   <span>` + shipping.city + ` ` + shipping.postcode + `, ` + shipping.state + ` </span>
                </div>

                   <span class="text-secondary">Items:</span>
                <div class="d-flex flex-column gap-2">` + list.join("") + `
                ` + payment_info + `
                </div>

        `)




      ColumnFormater.formatDate();
    },
    cartItems() {
      var count = 0,
        list = [],
        total_pv = 0,
        subtotal = 0.0;
      total_pv = commerceApp_.cart_.map((v, i) => {
        return (v.qty * v.point_value)
      }).reduce((a, b) => {
        return a + b
      }, 0)
      subtotal = commerceApp_.cart_.map((v, i) => {
        return (v.qty * v.retail_price)
      }).reduce((a, b) => {
        return a + b
      }, 0)
      count = commerceApp_.cart_.map((v, i) => {
        return v.qty
      }).reduce((a, b) => {
        return a + b
      }, 0)


      if ($("cartItems").attr("upgrade") != null) {
        subtotal = subtotal + memberApp_.user.rank.retail_price
      }
      console.log(subtotal)
      eligible_rank = this.evalRank(subtotal)



      commerceApp_.cart_.forEach((v, i) => {
        var img = '/images/placeholder.png';
        if (v.img_url != null) {

          try {
            img = v.img_url
          } catch (e) {
            img = '/images/placeholder.png'
          }
        }
        list.push(`

            <div class="d-flex align-items-center justify-content-between gap-2">
            <input type="hidden"  name="user[products][` + i + `][item_name]" value="` + v.name + `">
            <input type="hidden"  name="user[products][` + i + `][item_price]" value="` + v.retail_price + `">
            <input type="hidden"  name="user[products][` + i + `][item_pv]" value="` + v.point_value + `">
            <input type="hidden"  name="user[products][` + i + `][img_url]" value="` + v.img_url + `">
            <input type="hidden"  name="user[products][` + i + `][qty]" value="` + v.qty + `">
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
                <span>` + v.name + ` <small>(x` + v.qty + `)</small></span>
              </div>
              <div class="d-flex flex-column flex-lg-row justify-content-between align-items-center">
                <div class="d-flex flex-column align-items-end">
                  <span class="font-sm ">RP <span class="format-float">` + (v.retail_price * v.qty).toFixed(2) + `</span></span>
                  <span class="font-sm text-info format-integer">` + (v.point_value * v.qty) + ` PV</span>
                </div>
                <div class="text-center">
                  <div class="btn btn-sm" add-product-id="` + v.id + `"><i class="text-info fa fa-plus"></i></div>
                  <div class="btn btn-sm" minus-product-id="` + v.id + `"><i class="text-danger fa fa-minus"></i></div>
                  <div class="btn btn-sm" delete-product-id="` + v.id + `"><i class="text-danger fa fa-times"></i></div>
                </div>
              </div>
            </div>

          
            `)


      })
      $("cartItems").html(`

                <div class="d-flex flex-column gap-2">` + list.join("") + `
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-4">Subtotal</span>
                    <span class=" me-4">RP <span class="format-float">` + subtotal + `</span></span>
                  </div>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-5">Total PV</span>
                    <span class="text-info me-4"><span class="format-integer">` + total_pv + ` PV</span></span>
                  </div>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-secondary">Eligible Rank</span>
                    <span class="text-info me-4"><span class="format-integer">` + eligible_rank + `</span></span>
                  </div>
                </div>

 

        `)

      var user = memberApp_.user,
        wallets = []


      if (user.wallets == null) {

        wallets = phxApp_.api("user_wallet", {
          token: user.token
        })
        user.wallets = wallets
      } else {
        wallets = user.wallets
      }





      function appendWalletAttr() {
        if (wallets.length == 0) {} else {
          $("wallet").each((i, v) => {
            var check = wallets.filter((wv, wi) => {
              return wv.wallet_type == "direct_recruitment"
            })
            if (check.length > 0) {
              var wallet = check[0]
              $("#drp_payment").attr("max", wallet.total)
              $("#drp_payment").attr("min", subtotal / 2)
              $("#drp_payment").attr("value", subtotal / 2)
            } else {}
          })
        }
      }
      $("input[name='user[payment][method]']").unbind()
      $("input[name='user[payment][method]']").on("change", () => {
        $("#coupon-detail").addClass("d-none")

        $("input[name='user[payment][method]']").each((i, v) => {

          if ($(v)[0].checked == true) {

            if ($(v).val() == "register_point") {
              $("#coupon-detail").removeClass("d-none")

              drpChanged()
            } else {

              $("#drp_payment").removeAttr("max")
              $("#drp_payment").removeAttr("min")
              $("#drp_payment").removeAttr("value")
              commerceApp_.components["updateCart"]()
              commerceApp_.components["cartItems"]()
            }

          }
        })


      })


      function drpChanged() {
        appendWalletAttr()
        var drp_amount = 0
        if ($("#drp_payment").length > 0) {

          drp_amount = $("#drp_payment").val()
        }
        $("cartItems").html(`

                  <div class="d-flex flex-column gap-2">` + list.join("") + `
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fs-4">Subtotal</span>
                      <span class=" me-4">RP <span class="format-float">` + subtotal + `</span></span>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fs-4">Discount</span>
                      <span class=" me-4">- RP <span class="format-float">` + drp_amount + `</span></span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fs-5">Total PV</span>
                      <span class="text-info me-4"><span class="format-integer">` + (total_pv - drp_amount) + ` PV</span></span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="fw-bold text-secondary">Eligible Rank</span>
                      <span class="text-info me-4"><span class="format-integer">` + eligible_rank + `</span></span>
                    </div>
                  </div>


          `)
        $("[add-product-id]").each((i, v) => {
          var id = $(v).attr("add-product-id")

          function addItem() {
            commerceApp_.addItemById_(id)
            commerceApp_.components["updateCart"]()
            commerceApp_.components["cartItems"]()
            commerceApp_.toastChanges()

          }
          $(v)[0].onclick = addItem
        })
        $("[minus-product-id]").each((i, v) => {
          var id = $(v).attr("minus-product-id")

          function minusItem() {
            commerceApp_.minusItem_(id)
            commerceApp_.components["updateCart"]()
            commerceApp_.components["cartItems"]()
            commerceApp_.toastChanges()

          }
          $(v)[0].onclick = minusItem
        })

        $("[delete-product-id]").each((i, v) => {
          var id = $(v).attr("delete-product-id")

          function deleteItem() {
            commerceApp_.removeItem_(id)
            commerceApp_.components["updateCart"]()
            commerceApp_.components["cartItems"]()
            commerceApp_.toastChanges()
          }
          $(v)[0].onclick = deleteItem
        })
      }


      function drpChangeHandler(event) {

        $("#drp_payment").removeAttr("max")
        $("#drp_payment").removeAttr("min")
        $("#drp_payment").removeAttr("value")

        drpChanged()
      }

      drp_elem = document.getElementById("drp_payment")
      if (drp_elem != null) {
        drp_elem.removeEventListener("change", drpChangeHandler)
        drp_elem.addEventListener("change", drpChangeHandler)
      }

      $("[add-product-id]").each((i, v) => {
        var id = $(v).attr("add-product-id")

        function addItem() {
          commerceApp_.addItemById_(id)
          commerceApp_.components["updateCart"]()
          commerceApp_.components["cartItems"]()
          commerceApp_.toastChanges()

        }
        $(v)[0].onclick = addItem
      })
      $("[minus-product-id]").each((i, v) => {
        var id = $(v).attr("minus-product-id")

        function minusItem() {
          commerceApp_.minusItem_(id)
          commerceApp_.components["updateCart"]()
          commerceApp_.components["cartItems"]()
          commerceApp_.toastChanges()

        }
        $(v)[0].onclick = minusItem
      })

      $("[delete-product-id]").each((i, v) => {
        var id = $(v).attr("delete-product-id")

        function deleteItem() {
          commerceApp_.removeItem_(id)
          commerceApp_.components["updateCart"]()
          commerceApp_.components["cartItems"]()
          commerceApp_.toastChanges()
        }
        $(v)[0].onclick = deleteItem
      })


      $("input[name='user[payment][method]']").each((i, v) => {

        if ($(v)[0].checked == true) {

          if ($(v).val() == "register_point") {
            $("#coupon-detail").removeClass("d-none")

            drpChanged()
          } else {
            $("#drp_payment").removeAttr("max")
            $("#drp_payment").removeAttr("min")
            $("#drp_payment").removeAttr("value")
          }

        }
      })



      ColumnFormater.formatDate();
    },
    evalRank(subtotal) {


       var sort = [];
      memberApp_.ranks.map((v, i) => {
        sort.push(v)
      })

      sort.sort((a, b) => {
        return b.retail_price - a.retail_price
      })


      check = sort.filter((v, i) => {
        return v.retail_price <= subtotal
      })[0]

      var eligible_rank = "n/a"

      if (check) {
        eligible_rank = check.name
        if ($("input[name='user[rank_id]']").length > 0) {

          $("input[name='user[rank_id]']").val(check.id)
        }
      }

      return eligible_rank
    },
    updateCart() {
      var count = 0,
        list = [],
        subtotal = 0.0;

      subtotal = commerceApp_.cart_.map((v, i) => {
        return (v.qty * v.retail_price)
      }).reduce((a, b) => {
        return a + b
      }, 0)
      count = commerceApp_.cart_.map((v, i) => {
        return v.qty
      }).reduce((a, b) => {
        return a + b
      }, 0)

      $(".bc").html(count)

      commerceApp_.cart_.forEach((v, i) => {

        list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">
            <div style="width: 240px;" class="d-flex justify-content-between align-items-center">
              <span>` + v.name + ` <small>(x` + v.qty + `)</small></span>
              <div class="d-flex align-items-center justify-content-between gap-2">
                <span class="font-sm format-float">` + (v.retail_price * v.qty).toFixed(2) + `</span>

                <div class="d-lg-block d-none">
                  <div class="btn btn-sm" minus-product-id="` + v.id + `"><i class="text-danger fa fa-minus"></i></div>
                  <div class="btn btn-sm" delete-product-id="` + v.id + `"><i class="text-danger fa fa-times"></i></div>
                </div>
                

              </div>
            </div>

          </a></li>

            `)


      })

      if (list.length == 0) {

        list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">Empty</a></li>

            `)

      }

      var bg_ranks2 = [],
        sort = [];
      memberApp_.ranks.map((v, i) => {
        sort.push(v)
      })

      sort.sort((a, b) => {
        return a.retail_price - b.retail_price
      })

      sort.map((v, i) => {
        bg_ranks2.push(`
          <div class="col ">
            <div class="d-flex flex-column">
              <span>` + v.name + `</span>
              <span class="format-float">` + v.retail_price + `</span>
              
            </div>
          </div>`)
      })

      if ($("cartItems").attr("upgrade") != null) {
        subtotal = subtotal + memberApp_.user.rank.retail_price
      }

      eligible_rank = this.evalRank(subtotal)
      bg_ranks = [

        `  <div class="progress-bar bg-danger" role="progressbar" style="width: 15%;" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>`,
        `  <div class="progress-bar bg-warning" role="progressbar" style="width: 30%;" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>`,
        `  <div class="progress-bar bg-info" role="progressbar" style="width: 20%;" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>`

      ]

      perc = subtotal / memberApp_.ranks[2].retail_price * 100

      $(".ac").each((i, vv) => {

        var html = list.join("") + `
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
                </li>`


        $(vv).html(html)
      })



      $("[minus-product-id]").each((i, v) => {
        var id = $(v).attr("minus-product-id")

        function minusItem() {
          commerceApp_.minusItem_(id)
          commerceApp_.components["updateCart"]()
          commerceApp_.toastChanges()
        }
        $(v)[0].onclick = minusItem
      })

      $("[delete-product-id]").each((i, v) => {
        var id = $(v).attr("delete-product-id")

        function deleteItem() {
          commerceApp_.removeItem_(id)
          commerceApp_.components["updateCart"]()
          commerceApp_.toastChanges()
        }
        $(v)[0].onclick = deleteItem
      })

      ColumnFormater.formatDate();

    },
    cart() {
      var count = 0,
        list = [],
        subtotal = 0.0;

      subtotal = commerceApp_.cart_.map((v, i) => {
        return (v.qty * v.retail_price)
      }).reduce((a, b) => {
        return a + b
      }, 0)
      count = commerceApp_.cart_.map((v, i) => {
        return v.qty
      }).reduce((a, b) => {
        return a + b
      }, 0)

      commerceApp_.cart_.forEach((v, i) => {

        list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">
            <div style="width: 240px;" class="d-flex justify-content-between align-items-center">
              <span>` + v.name + ` <small>(x` + v.qty + `)</small></span>
              <div class="d-flex align-items-center justify-content-between gap-2">
                <span class="font-sm format-float">` + (v.retail_price * v.qty).toFixed(2) + `</span>


                <div class="d-lg-block d-none">
                  <div class="btn btn-sm" minus-product-id="` + v.id + `"><i class="text-danger fa fa-minus"></i></div>
                  <div class="btn btn-sm" delete-product-id="` + v.id + `"><i class="text-danger fa fa-times"></i></div>
                </div>

              </div>
            </div>

          </a></li>

            `)


      })

      if (list.length == 0) {

        list.push(`

          <li><a class="dropdown-item" href="javascript:void(0);">Empty</a></li>

            `)

      }
      var bg_ranks2 = [],
        sort = [];
      memberApp_.ranks.map((v, i) => {
        sort.push(v)
      })

      sort.sort((a, b) => {
        return a.retail_price - b.retail_price
      })

      sort.map((v, i) => {
        bg_ranks2.push(`
          <div class="col ">
            <div class="d-flex flex-column">
              <span>` + v.name + `</span>
              <span class="format-float">` + v.retail_price + `</span>
              
            </div>
          </div>`)
      })

      if ($("cartItems").attr("upgrade") != null) {
        subtotal = subtotal + memberApp_.user.rank.retail_price
      }
      eligible_rank = this.evalRank(subtotal)
      perc = subtotal / memberApp_.ranks[0].retail_price * 100

      $("cart").each((i, v) => {
        var needDropUp = `dropdown`

        if ($(v).attr("dropup") != null) {
          needDropUp = `dropup`
        }
        $(v).html(`
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
        `)
      })





      $("[minus-product-id]").each((i, v) => {
        var id = $(v).attr("minus-product-id")

        function minusItem() {
          commerceApp_.minusItem_(id)
          commerceApp_.components["updateCart"]()
        }
        $(v)[0].onclick = minusItem
      })

      $("[delete-product-id]").each((i, v) => {
        var id = $(v).attr("delete-product-id")

        function deleteItem() {
          commerceApp_.removeItem_(id)
          commerceApp_.components["updateCart"]()
        }
        $(v)[0].onclick = deleteItem
      })

      ColumnFormater.formatDate();

    },
    product() {
      $("product").html(`
          <div class="text-center mt-4">
            <div class="spinner-border loading2" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
          </div>
            
        <div class="loading2 d-none" id="pcontent" />
        `)

      phxApp_.api("get_product", {
        id: pageParams.id
      }, null, (data) => {
        $("title").html(data.name)

        function addToCart_() {
          commerceApp_.addItem_(data)
          commerceApp_.components["updateCart"]()

          phxApp_.notify("Added " + data.name, {
            delay: 2000,
            type: "success",
            placement: {
              from: "top",
              align: "center"
            }
          })
          phxApp_.toast({ content: `<div class=""><ul class="">` + $(".ac").html() + `</ul></div>` })

        }

        $(".spinner-border.loading2").parent().remove()
        $(".loading2").removeClass("d-none")


        var img
        if (data.img_url != null) {

          try {
            img = data.img_url
          } catch (e) {
            img = '/images/placeholder.png'
          }
        }
        $("#pcontent").html(`

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
          <div style="margin-top: 50px;">` + data.desc + `</div>
          <div class="font-sm fw-light text-secondary text-center format-float">` + data.retail_price + `</div>
          <div class="font-sm fw-light text-info text-center ">PV <span class="format-float">` + data.point_value + `</span></div>
          <div class="btn btn-outline-primary mt-4" product-id="` + data.id + `">Add</div>
        </div>

        `)
        $("#ptitle").html(
          data.name
        )
        $("[product-id='" + data.id + "']")[0].onclick = addToCart_

      })


    },
    products() {

      $("products").html(`
          <div class="text-center mt-4">
            <div class="spinner-border loading" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
          </div>
            

          <div class="row gx-0 d-none loading">
            <div class="col-12 col-lg-10 offset-lg-1">
              <div id="tab1"></div>
            </div>
          </div>
        `)



      var customCols = null,
        random_id = 'products',
        productSource = new phoenixModel({
          onDrawFn: () => {
            $(".spinner-border.loading").parent().remove()
            $(".loading").removeClass("d-none")

            setTimeout(() => {
              ColumnFormater.formatDate()
            }, 200)

          },
          xcard: (params) => {

            var data = params,
              img = '/images/placeholder.png';
            if (data.img_url != null) {

              try {
                img = data.img_url
              } catch (e) {
                img = '/images/placeholder.png'
              }
            }
            var card = `
          <div  class="m-2 d-flex flex-column gap-2" onclick="phxApp.navigateTo('/products/` + data.id + `/` + data.name + `')">
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
            <div class="d-flex flex-column justify-content-center gap-2 mt-4">
              <div class="font-sm fw-bold text-center">` + data.name + `</div>
               <div class="d-flex flex-column justify-content-center ">
                  <div class="font-sm fw-light text-secondary text-center format-float">` + data.retail_price + `</div>
                  <div class="font-sm fw-light text-info text-center ">PV <span class="format-float">` + data.point_value + `</span></div>
               </div>
           
            </div>
          </div>
          `
            return card
          },
          data: {
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
              label: 'id',
              data: 'id'
            }, {
              label: 'Action',
              data: 'id'
            }

          ],
          moduleName: "Product",
          link: "Product",
          customCols: customCols,
          buttons: [],
          tableSelector: "#" + random_id
        })
      productSource.load(random_id, "#tab1")


    },
    announcement() {
      try {

        $(".anc").slick('destroy')
      } catch (e) {

      }
      $("announcement").html(`
        <div class="spinner-border" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
        `)

      phxApp_.api("announcements", {

      }, null, (list) => {

        $("announcement").html(``)

        list.forEach((v, i) => {

          function showContent() {
            phxApp_.modal({
              selector: "#mySubModal",
              content: v.content,
              autoClose: false,
              header: v.title
            })
          }


          var url = v.img_url,
            doc = `
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

          `

          $("announcement").append(doc)

          $("[announcement-id='" + v.id + "']")[0].onclick = showContent



        })

      })

      $(".anc").slick()
    },
    rewardList() {

      $("rewardList").html(`
          <div class="text-center mt-4">
            <div class="spinner-border loading" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>
          </div>
            

          <div class="row gx-0 d-none loading">
            <div class="col-12">
              <div id="tab1">No rewards</div>
            </div>
          </div>
        `)


      phxApp_.api("get_reward_summary", { user_id: memberApp_.user.id }, null, (r) => {



        $(".spinner-border.loading").parent().remove()
        $(".loading").removeClass("d-none")
        var rewards = ["sharing bonus", "team bonus", "matching bonus", "elite leader", "travel fund", "repurchase bonus", "drp sales level bonus"],
          list = []
        rewards.forEach((r2, ii) => {


          r.forEach((v, i) => {
            if (r2 == v.name) {

              list.push(`

            <div class="my-2 d-flex align-items-center justify-content-between">

              <span class="fs-5">
                ` + ColumnFormater.capitalize(v.name) + `
              </span>
              <span class="d-flex justify-content-between gap-2 align-items-center">
                <span class="format-float">
                  ` + v.sum + `
                </span>
                <a href="/reward_details/` + v.name + `" class="navi btn btn-info btn-sm">
                <i class="fa fa-info"></i>
                </a>
              </span>
            </div>


                `)

            }
          })
        })

        $("#tab1").html(`` + list.join("") + ``)
        phxApp.formatDate()
      })


    },
    wallet() {
      if (memberApp_.user != null) {

        var user = memberApp_.user,
          wallets = phxApp_.api("user_wallet", {
            token: user.token
          })


        if (wallets.length == 0) {
          $("wallet").parent().html(`<div class="p-4">Wallet info expired</div>`)
        } else {

          $("wallet").each((i, v) => {
            var check = wallets.filter((wv, wi) => {
              return wv.wallet_type == $(v).attr("aria-data")
            })

            if (check.length > 0) {

              var wallet = check[0]


              var wallet_name = $(v).attr("aria-data").split("_").map((v, i) => {
                return ColumnFormater.capitalize(v)
              }).join(" ")

              $(v).html(`
              <a href="/wallets/` + wallet.id + `" class="navi" >
              <div class="card mb-3 mb-lg-0">
                <div class="card-body p-1 py-2 ">
                  <div class="d-flex gap-1 align-items-center">
                    <div wallet-id="` + wallet.id + `" class="d-none d-lg-block mx-2 py-2 btn btn-outline-success rounded-xl">
                      <i class=" fa fa-dollar-sign "></i>
                    </div>
                    <div class="ps-2 ps-lg-0">
                      <span class="text-sm text-secondary text-truncate">` + wallet_name + `</span>
                      <div class="d-flex align-items-center gap-2">
                        <div class="fs-4 format-int" style="">` + wallet.total + `</div>
                        <small>pts</small>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              </a>

          `)
            } else {

            }



          })
        }

        ColumnFormater.formatDate()
      }





    },
    userProfile() {


      var user = memberApp_.user;
      var name = user != null ? "Welcome! " + `<a href="/profile" class="navi">` + user.fullname + ` (` + user.rank.name + `)</a>` : `<a href="/login" class="navi">Login</a>`
      $("userProfile").html(`
            
              ` + name + `
           
        `)
    },


  }

}