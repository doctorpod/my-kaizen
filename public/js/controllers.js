const application = window.Stimulus.Application.start();

application.register(
  "item",
  class extends window.Stimulus.Controller {
    static get targets() {
      return ["count"];
    }

    check() {
      const item_id = parseInt(this.data.get("id"));

      fetch("/checks", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ item_id: item_id })
      })
        .then(response => response.json())
        .then(data => {
          this.countTarget.innerHTML = data.item_count;
          document.getElementById(
            `card-${data.card.id}-total-today`
          ).innerHTML = data.card.total.today;
          document.getElementById(
            `card-${data.card.id}-total-yesterday`
          ).innerHTML = data.card.total.yesterday;
        });
    }
  }
);
