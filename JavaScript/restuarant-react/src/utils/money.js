export const TAX_RATE = 0.0825;
export const toCents = (price) => Math.round(price * 100);
export const money = (cents) =>
    new Intl.NumberFormat('en-US', {
      style: 'currency', currency: 'USD',
    }).format(cents / 100);

export function calculateTotals(cart) {
  const subtotal = cart.reduce((sum, item) => sum + toCents(item.price) * item.quantity, 0);
  const tax = Math.round(subtotal * TAX_RATE);
  return { subtotal, tax, total: subtotal + tax };
}
