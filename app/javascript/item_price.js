const item_price = () => {
  let priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    const salesProfit = document.getElementById("profit");
    salesProfit.innerHTML = inputValue - Math.floor(inputValue * 0.1);
  });
};

document.addEventListener("turbo:load",item_price);
document.addEventListener("turbo:render",item_price);