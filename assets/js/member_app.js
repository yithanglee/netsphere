import { phxApp_ } from './phx_app.js';
export let memberApp_ = {
  user: {},
  restoreUser() {
    this.user = JSON.parse(localStorage.getItem("user"));
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
  login(dom) {
    console.log(dom)
    $(dom).closest("form")
    phxApp_.form($(dom).closest("form"), "login", (j) => {
      memberApp_.user = j
      memberApp_.save(j)
      phxApp_.navigateTo("/home")
    })
  }
}