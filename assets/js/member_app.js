import { phxApp_ } from './phx_app.js';
export let memberApp_ = {
  user: {},
  restoreUser() {
    this.user = JSON.parse(localStorage.getItem("user"));

    if (this.user != null) {
      $("[aria-label='login']").addClass("d-none")
      $("[aria-label='logout']").removeClass("d-none")
    }


  },
  save(j) {
    localStorage.setItem("user", JSON.stringify(j))
  },
  register(dom) {
    console.log(dom)
    $(dom).closest("form")
    phxApp_.form($(dom).closest("form"), "register", () => {
      phxApp_.navigateTo("/home")
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
  login(dom) {
    console.log(dom)
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