const application = window.Stimulus.Application.start();

application.register(
  "deck",
  class extends window.Stimulus.Controller {
    connect() {
      this.startRefreshing();
    }

    disconnect() {
      this.stopRefreshing();
    }

    startRefreshing() {
      this.refreshTimer = setInterval(() => {
        this.checkForRefresh();
      }, 15000);
    }

    checkForRefresh() {
      const d = new Date();
      const today = d.toLocaleDateString();

      console.log("deck checking...");

      if (today !== this.data.get("refreshed")) {
        this.data.set("refreshed", today);
        console.log("date has changed fetching a refresh TODO");
      }
    }

    stopRefreshing() {
      if (this.refreshTimer) {
        clearInterval(this.refreshTimer);
      }
    }
  }
);

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
        body: JSON.stringify({
          item_id: item_id,
          client_date: new Date().toLocaleDateString()
        })
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
