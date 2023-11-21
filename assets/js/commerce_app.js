import {
  ColumnFormater
} from './column_formatter.js';
import {
  phoenixModel
} from './phoenixModel.js';
export let commerceApp_ = {
  cart_: [],

  restoreCart() {
    if (localStorage.getItem("cart") != null) {
      this.cart_ = JSON.parse(localStorage.getItem("cart"));
    }


  },
  addItem_(item) {

    var searchObject = item;

    var index = this.cart_.findIndex(item => item.id === searchObject.id);
    console.log("index " + index)
    if (index >= 0) {

      var foundItem = this.cart_[index]
      foundItem.qty += 1

    } else {
      item.qty = 1
      this.cart_ = [item, ...this.cart_]

    }


    localStorage.setItem("cart", JSON.stringify(this.cart_))
    console.log(this.cart_)
  },
  minusItem_(id) {


    var index = this.cart_.findIndex(item => item.id == parseInt(id));
    console.log("index " + index)
    if (index >= 0) {

      var foundItem = this.cart_[index]
      phxApp.notify("item " + foundItem.name + " deducted !", {
        delay: 2000,
        type: "success",
        placement: {
          from: "top",
          align: "center"
        }
      })
      foundItem.qty -= 1

    } else {
      // item.qty = 1
      // this.cart_ = [item, ...this.cart_]

    }


    localStorage.setItem("cart", JSON.stringify(this.cart_))
    console.log(this.cart_)
  },
  removeItem_(id) {
    var index = this.cart_.findIndex(item => item.id == parseInt(id));
    var foundItem = this.cart_[index]

    phxApp.notify("item " + foundItem.name + " removed !", {
      delay: 2000,
      type: "warning",
      placement: {
        from: "top",
        align: "center"
      }
    })
    var removed = this.cart_.splice(index, 1)
    localStorage.setItem("cart", JSON.stringify(this.cart_))
    console.log(this.cart_)
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
    var list = ["cart", "cartItems", "userProfile", "wallet", "announcement", "products", "product", "rewardList"]

    list.forEach((v, i) => {
      console.log("rendering components")
      console.log(v)
      if ($(v).length > 0) {

        this.components[v]()
      }
    })
  },
  components: {
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
                  <span class="font-sm ">$ <span class="format-float">` + (v.retail_price * v.qty).toFixed(2) + `</span></span>
                  <span class="font-sm text-info format-integer">` + (v.point_value * v.qty) + ` PV</span>
                </div>
                <div class="text-center">
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
                    <span class=" me-4">$ <span class="format-float">` + subtotal + `</span></span>
                  </div>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fs-5">Total PV</span>
                    <span class="text-info me-4"><span class="format-integer">` + total_pv + ` PV</span></span>
                  </div>
                </div>

        `)

      $("[minus-product-id]").each((i, v) => {
        var id = $(v).attr("minus-product-id")

        function minusItem() {
          commerceApp_.minusItem_(id)
          commerceApp_.components["updateCart"]()
          commerceApp_.components["cartItems"]()
        }
        $(v)[0].onclick = minusItem
      })

      $("[delete-product-id]").each((i, v) => {
        var id = $(v).attr("delete-product-id")

        function deleteItem() {
          commerceApp_.removeItem_(id)
          commerceApp_.components["updateCart"]()
          commerceApp_.components["cartItems"]()
        }
        $(v)[0].onclick = deleteItem
      })

      ColumnFormater.formatDate();
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
      console.log("updateing...")


      $(".ac").each((i, vv) => {
        console.log(vv)
        var html = list.join("") + `
                <li id="divider">
                  <hr class="dropdown-divider">
                </li>
               <li><a class="dropdown-item navi" href="/register">
                  
                  <div class="d-flex justify-content-between align-items-center">
                    <span>Checkout</span>
                    <span class="format-float">` + subtotal + `</span>
                  </div>
                </a></li>`

        console.log(html)
        $(vv).html(html)
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

      $("cart").each((i, v) => {

        $(v).html(`
            <div class="dropdown  ">
              <div class="mx-3 py-2 btn btn-outline-success rounded-xl position-relative"  data-bs-toggle="dropdown" aria-expanded="false">
                <div style="top: 4px !important;" class="badge bg-warning position-absolute top-0 start-100 translate-middle bc">` + count + `</div>
                <i class="fa fa-shopping-cart"></i>
              </div>
              <ul class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start ac">
                ` + list.join("") + `
                <li id="divider">
                  <hr class="dropdown-divider">
                </li>
                <li><a class="dropdown-item navi" href="/register">
                  
                  <div class="d-flex justify-content-between align-items-center">
                    <span>Checkout</span>
                    <span class="format-float">` + subtotal + `</span>
                  </div>
                </a></li>
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

      phxApp.api("get_product", {
        id: pageParams.id
      }, null, (data) => {
        function addToCart_() {
          commerceApp_.addItem_(data)
          commerceApp_.components["updateCart"]()

          phxApp.notify("Added " + data.name, {
            delay: 2000,
            type: "success",
            placement: {
              from: "top",
              align: "center"
            }
          })

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
            console.log(params)
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
          <div onclick="phxApp.navigateTo('/products/` + data.id + `/` + data.name + `')">
            <div  class="d-flex justify-content-center p-4 " 
                  style="
                    cursor: pointer;   
                    position: relative; 
                    height: 260px;">
              <div class="rounded py-2" style="
                    height: 220px;
                    width: 80%;
                    filter: blur(4px);
                    position: absolute;
                    background-repeat: no-repeat;
                    background-position: center;
                    background-size: cover;
                    background-image: url('` + img + `');
                    bottom: 10px;
                    left: 20px;
                    ">
              </div>
              <div class="rounded py-2" style="
                    height: 220px;
                    width:  100%;
                    z-index: 1;
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover; 
                    background-image: url('` + img + `');
                    ">
              </div>
            </div>
            <div class="d-flex flex-column justify-content-center gap-2">
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
            grid_class: "col-6 col-lg-3",
            dom: '<"row px-4"<"col-lg-6 col-12"i><"col-12 col-lg-6">><"row grid_view "><"list_view d-none"t><"row transform-75 px-4"<"col-lg-6 col-12"><"col-lg-6 col-12"p>>'
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

      phxApp.api("announcements", {

      }, null, (list) => {

        $("announcement").html(``)

        list.forEach((v, i) => {

          function showContent() {
            phxApp.modal({
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
            <div class="col-12 col-lg-10 offset-lg-1">
              <div id="tab1"></div>
            </div>
          </div>
        `)



      var customCols = null,
        random_id = "rewards"
      rewardSource = new phoenixModel({
        onDrawFn: () => {
          $(".spinner-border.loading").parent().remove()
          $(".loading").removeClass("d-none")

          setTimeout(() => {
            phxApp.formatDate()


          }, 200)


        },
        xcard: (params) => {
          console.log(params)
          var data = params

          var font_class = "text-success", paid = `<span class="badge bg-warning">UNPAID</span>`
          if (data.amount < 0) {
            font_class = "text-danger"
          }

          if (data.is_paid) {
            paid = `<span class="badge bg-success">PAID</span>`
          }

          var card = `
          <div class="row mt-2" >
           <div class="col-8 text-secondary format_datetime text-sm">` + data.inserted_at + `</div>
      
           <div class="col-4 text-sm text-end">` + paid + `</div>
          </div>
          <div class="row " >
           
           <div class="col-12 text-sm">` + data.remarks + `</div>
          </div>

          <div class="row">
           <div class="col-6 text-start text-sm">Bonus</div>
           <div class="col-6 text-end text-sm">Amount</div>
          </div>
          <div class="row">
           <div class="col-6 text-start">` + data.name + `</div>
           <div class="col-6 text-end  format-float ` + font_class + `">` + data.amount + `</div>
           
          </div>

          `
          return card
        },
        data: {
          grid_class: "col-12 ",
          dom: `
        <"row px-4"
          <"col-lg-6 col-12"i>
          <"col-12 col-lg-6">
        >
        <"row grid_view d-block d-lg-none">
        <"list_view d-none d-lg-block"t>
        <"row transform-75 px-4"
            <"col-lg-6 col-12">
            <"col-lg-6 col-12"p>
          >
      `,


          preloads: ["user"],
          additional_join_statements: [{

            user: "user"

          }],
          additional_search_queries: [
            "b.id=" + memberApp.user.id
          ],
        },
        columns: [

          {
            label: 'id',
            data: 'id',
            className: "d-none"
          },


          {
            label: 'Date',
            data: 'inserted_at',
            formatDateTime: true,
            offset: 0
          },
          {
            label: 'Paid?',
            data: 'is_paid',
            showBoolean: true
          },
          {
            label: 'Bonus',
            data: 'name'
          },

          {
            label: 'Amount',
            className: "text-end",
            data: 'amount',
            formatFloat: true
          },
          {
            label: 'Calculation',
            data: 'remarks'
          }, {
            label: 'Action',
            data: 'id',
            className: "d-none"
          }

        ],
        moduleName: "Reward",
        link: "Reward",
        customCols: customCols,
        buttons: [],
        tableSelector: "#" + random_id
      })

      rewardSource.load(random_id, "#tab1")
    },
    wallet() {
      if (memberApp.user != null) {

        var user = memberApp.user,
          wallets = phxApp.api("user_wallet", {
            token: user.token
          })
        $("wallet").each((i, v) => {
          var wallet = wallets.filter((wv, wi) => {
            return wv.wallet_type == $(v).attr("aria-data")
          })[0]

          console.log(wallet)
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



        })

        ColumnFormater.formatDate()
      }





    },
    userProfile() {


      var user = memberApp.user;
      var name = user != null ? "Welcome! " + `<a href="/profile" class="navi">` + user.fullname + `</a>` : `<a href="/login" class="navi">Login</a>`
      $("userProfile").html(`
            
              ` + name + `
           
        `)
    },


  }

}