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
  }

}