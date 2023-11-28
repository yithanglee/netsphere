import { phxApp_ } from './phx_app.js';
import { commerceApp_ } from './commerce_app.js';
export let memberApp_ = {
  user: {},
  ranks: [],
  restoreUser() {


    this.ranks = phxApp_.api("get_ranks", {})

    this.user = JSON.parse(localStorage.getItem("user"));

    if (this.user != null) {
      $("[aria-label='login']").addClass("d-none")
      $("[aria-label='logout']").removeClass("d-none")
    }


    if ($("form#register")) {
      if (this.user != null) {
        $("input[name='user[sales_person_id]']").val(this.user.id)
        $("input[name='user[sponsor]']").val(this.user.username)
        $("input[name='user[username]']").val("")

      }

    }



  },
  save(j) {
    localStorage.setItem("user", JSON.stringify(j))
  },
  register(dom) {
    $(dom).closest("form")



    phxApp_.validateForm("form", () => {
      console.log("validating form...")

      phxApp_.form($(dom).closest("form"), "register", (e) => {

      console.log("after register form...")
        console.log(e)
        if (e != null) {

          commerceApp_.emptyCart_()
          window.location = e.payment_url
        } else {

          commerceApp_.emptyCart_()
          phxApp_.navigateTo("/register")
        }

      })
    })
  },
  logout() {
    console.log("logging out...")
    localStorage.removeItem("user")

    $("[aria-label='login']").removeClass("d-none")
    $("[aria-label='logout']").addClass("d-none")
    phxApp_.notify("Log out!")
    phxApp_.navigateTo("/home")
  },
  updateUser(user) {
    memberApp_.user = user
    memberApp_.save(user)
  },
  login(dom) {

    $(dom).closest("form")
    phxApp_.form($(dom).closest("form"), "login", (j) => {
      memberApp_.user = j
      memberApp_.save(j)

      $("[aria-label='login']").addClass("d-none")
      $("[aria-label='logout']").removeClass("d-none")
      phxApp_.navigateTo("/home")
    })
  }
}