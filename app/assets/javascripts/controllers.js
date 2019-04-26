const application = window.Stimulus.Application.start();

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
      fetch(`/cards/?client_date=${date}`, {}).then(response => {
        response.text().then(html => {
          this.deckTarget.innerHTML = html;
        });
      });
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
          this.countTarget.innerHTML = data.item.count;
          document.getElementById(
            `card-${data.item.card.id}-score-today`
          ).innerHTML = data.item.card.scores.today;
          document.getElementById(
            `card-${data.item.card.id}-score-yesterday`
          ).innerHTML = data.item.card.scores.yesterday;
          document.getElementById(
            `card-${data.item.card.id}-recent-average`
          ).innerHTML = data.item.card.scores.recent_average;
        });
    }
  }
);