/**
 * 
 * @param {*} selected_id 
 * @param {*} menu_id 
 * @param {*} toggle_class 
 */
function addToggleListener(selected_id, menu_id, toggle_class) {
    let selected_element = document.querySelector(`#${selected_id}`);
    let btnIcons = [];

    if (selected_element.querySelector("svg") != null) {
        selected_element.querySelectorAll("svg").forEach((svg) => {
            btnIcons.push(svg);
        })
    }

    selected_element.addEventListener("click", function(event) {
        event.preventDefault();
        let menu = document.querySelector(`#${menu_id}`)
        menu.classList.toggle(toggle_class);
        btnIcons.forEach((svg) => {
            svg.classList.toggle("hidden");
        });
    });
}

document.addEventListener("turbo:load", function() {
    // ID, MENU, STATE
    addToggleListener("mobile-button", "mobile-menu", "hidden")
})