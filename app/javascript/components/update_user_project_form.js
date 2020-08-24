import Rails from "@rails/ujs"

const updateAndProgress = () => {
  const forms = document.querySelectorAll('.edit_user_project');
  if (forms) {
    forms.forEach((form) => {
      console.log(form);
      form.addEventListener('click', (event) => {
        event.preventDefault();
        Rails.fire(form, "submit");
        const tab = document.querySelector(`#${form.dataset.nextTab}`)
        console.log(form.dataset.nextTab);
        tab.click()
      })
    })
  }
}


export {updateAndProgress};
