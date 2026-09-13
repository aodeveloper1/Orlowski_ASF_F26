const MENU_ITEMS = [
    { id: 1, name: "Clockwork Coffee", description: "Black coffee from the steam-powered urn.", price: 0.03, category: "Breakfast" },
    { id: 2, name: "High-Pressure Hardtack", description: "Two regulation biscuits, softened on request.", price: 0.04, category: "Breakfast" },
    { id: 3, name: "Molasses Cornbread", description: "A square of cornmeal bread with molasses.", price: 0.06, category: "Breakfast" },
    { id: 4, name: "Cornmeal Mush", description: "Warm cornmeal porridge from the boiler galley.", price: 0.05, category: "Breakfast" },
    { id: 5, name: "Boiler-Room Bean Pot", description: "Slow-cooked beans with salt pork.", price: 0.10, category: "Lunch" },
    { id: 6, name: "Salt-Meat Sandwich", description: "Salted meat between softened hardtack slabs.", price: 0.12, category: "Lunch" },
    { id: 7, name: "Telegraph Lentils", description: "Lentils, onion and carrots, dispatched piping hot.", price: 0.08, category: "Lunch" },
    { id: 8, name: "Forager’s Soup", description: "Barley and the quartermaster’s available vegetables.", price: 0.07, category: "Lunch" },
    { id: 9, name: "Quartermaster’s Stew", description: "Beef, potato and onion in a hearty broth.", price: 0.18, category: "Dinner" },
    { id: 10, name: "Pneumatic Pot Pie", description: "Vegetable-and-chicken gravy beneath a biscuit crust.", price: 0.20, category: "Dinner" },
    { id: 11, name: "Ironclad Fish Cakes", description: "Salt fish and potato cakes with stewed cabbage.", price: 0.15, category: "Dinner" },
    { id: 12, name: "The General’s Roast", description: "Roast beef, potatoes and gravy, followed by apple duff.", price: 0.35, category: "Dinner" }
];

const money = new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD"
});

//dynamically populate hte table using all elements of MENU_ITEMS
const menuBody = document.getElementById("menu-items");
if (menuBody) {
    for (const item of MENU_ITEMS) {
        const row = document.createElement("tr");
        for (const value of [item.name, item.description, item.category, money.format(item.price)]) {
            const cell = document.createElement("td");
            cell.textContent = value;
            row.appendChild(cell);
        }
        menuBody.appendChild(row);
    }
}

const reservationForm = document.getElementById("reservation-form");
if (reservationForm) {
    const result = document.getElementById("reservation-result");

    reservationForm.addEventListener("submit", function (event) {
        event.preventDefault();
        const fields = reservationForm.elements;
        const name = fields["unit-name"].value.trim();
        const email = fields.email.value.trim();
        const unitSize = Number(fields["unit-size"].value);
        const date = fields.date.value;
        const time = fields.time.value;
        const seating = fields["seating-preference"].value;
        const dietaryNotes = fields["dietary-notes"].value.trim();
        const newsletter = fields.newsletter.checked;
        const errors = [];

        if (!name) {
            errors.push("Enter your unit name.");
        } else if (name.length > 20) {
            errors.push("Unit name must be 20 characters or fewer.");
        }
        if (!email.includes('@')) {
            errors.push("Enter a valid email address.");
        }
        if (!Number.isInteger(unitSize) || unitSize < 1 || unitSize > 8) {
            errors.push("Choose a unit size from 1 to 8 (x1000) Soldiers.");
        }
        if (!date) {
            errors.push("Choose a date.");
        }
        if (!time) {
            errors.push("Choose a time.");
        }
        if (!["air-drop-only", "cold-rations-only", "full-service"].includes(seating)) {
            errors.push("Choose a seating preference.");
        }
        if (dietaryNotes.length > 30) {
            errors.push("Dietary notes must be 30 characters or fewer.");
        }

        result.replaceChildren();  // get rid of last result if exists
        const alert = document.createElement("div");
        alert.setAttribute("role", "alert");
        if (errors.length > 0) {
            alert.className = "alert alert-danger";
            const list = document.createElement("ul");
            list.className = "mb-0";
            for (const error of errors) {
                const item = document.createElement("li");
                item.textContent = error;
                list.appendChild(item);
            }
            alert.appendChild(list);
        } else {
            const reservation = { name, email, unitSize, date, time, seating, dietaryNotes, newsletter };
            console.log(reservation);
            alert.className = "alert alert-success";
            alert.textContent = "Reservation details are valid. Your request has been logged to the console.";
        }
        result.appendChild(alert);
    });

    reservationForm.addEventListener("reset", function () {
        result.replaceChildren();
    });
}
