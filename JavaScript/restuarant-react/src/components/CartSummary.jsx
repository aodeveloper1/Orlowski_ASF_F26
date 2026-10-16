import {Card, CardBody} from 'reactstrap';
import {TAX_RATE, toCents, money, calculateTotals} from '../utils/money.js';

export default function CartSummary({cart}) {
    const {subtotal, tax, total} = calculateTotals(cart);
    return <Card><CardBody>
        <h2 className="h4">Order Summary</h2>
        <dl className="totals">
            <div>
                <dt>Subtotal</dt>
                <dd>{money(subtotal)}</dd>
            </div>
            <div>
                <dt>Tax (8.25%)</dt>
                <dd>{money(tax)}</dd>
            </div>
            <div className="grand-total">
                <dt>Final total</dt>
                <dd>{money(total)}</dd>
            </div>
        </dl>
    </CardBody></Card>;
}
