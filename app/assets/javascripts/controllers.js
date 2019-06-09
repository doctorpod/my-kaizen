const application = window.Stimulus.Application.start();

function handleHttpErrors(response) {
  if (!response.ok) {
    throw Error(response.statusText);
  }
  return response;
}

function displayError(error) {
  $("#errorMessage .techMessage").html(error.message);
  $("#errorMessage").modal();
}

application.register(
  "cards",
  class extends window.Stimulus.Controller {
    static get targets() {
      return ["deck"];
    }

    connect() {
      this.checkForRefresh();
      this.startRefreshing();
    }

    disconnect() {
      this.stopRefreshing();
    }

    startRefreshing() {
      this.refreshTimer = setInterval(() => {
        this.checkForRefresh();
      }, 5000);
    }

    checkForRefresh() {
      const d = new Date();
      const today = d.toLocaleDateString();

      if (today !== this.data.get("refreshed")) {
        this.data.set("refreshed", today);
        this.refresh(today);
      }
    }

    stopRefreshing() {
      if (this.refreshTimer) {
        clearInterval(this.refreshTimer);
      }
    }

    refresh(date) {
      fetch(`/cards/deck?client_date=${date}`, {})
        .then(handleHttpErrors)
        .then(response => {
          response.text().then(html => {
            this.deckTarget.innerHTML = html;
          });
        })
        .catch(error => {
          $("#deck-spinner .spinner-border").hide();
          displayError(error);
        });
    }
  }
);

application.register(
  "item",
  class extends window.Stimulus.Controller {
    static get targets() {
      return ["count", "spinner"];
    }

    check() {
      const item_id = parseInt(this.data.get("id"));

      this.spinnerTarget.classList.toggle("hide", false);

      fetch("/checks", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          item_id: item_id,
          client_date: new Date().toLocaleDateString()
        })
      })
        .then(handleHttpErrors)
        .then(response => response.json())
        .then(data => {
          this.countTarget.innerHTML = data.item.count;
          $(`#card${data.item.card.id} .score-today`).html(
            data.item.card.scores.today
          );

          $(`#card${data.item.card.id} .score-yesterday`).html(
            data.item.card.scores.yesterday
          );

          $(`#card${data.item.card.id} .recent-average`).html(
            data.item.card.scores.recent_average
          );

          $(`#card${data.item.card.id} .rewards`).html(
            data.item.card.rewards.join("")
          );

          this.spinnerTarget.classList.toggle("hide", true);
        })
        .catch(error => {
          this.spinnerTarget.classList.toggle("hide", true);
          displayError(error);
        });
    }
  }
);
