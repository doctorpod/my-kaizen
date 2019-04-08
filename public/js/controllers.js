const application = window.Stimulus.Application.start();

application.register(
  "item",
  class extends window.Stimulus.Controller {
    static get targets() {
      return ["count"];
    }

    check() {
      const count = parseInt(this.countTarget.innerHTML);
      this.countTarget.innerHTML = count + 1;
    }
  }
);
