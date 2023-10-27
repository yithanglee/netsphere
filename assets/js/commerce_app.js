export let commerceApp_ = {
  cart_: [],
  addItem_(item) {
    this.cart_ = [item, ...this.cart_]
    console.log(this.cart_)
  },
  removeItem_(index) {
    var removed = this.cart_.splice(index, 1)[0]
    console.log("item " + removed.name + " removed !")
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
    var list = ["cart"]

    list.forEach((v, i) => {
    console.log("rendering components")
      console.log(v)
      this.components[v]( )
    })
  },
  components: {
    cart() {

      $("cart").html(`
            <div class="d-lg-none d-block mx-4 py-2 btn btn-outline-primary rounded-xl">
              <i class="fa fa-shopping-cart"></i>
            </div>
        `)


    }
  }

}