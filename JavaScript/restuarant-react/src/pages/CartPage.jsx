import {useState} from 'react';
import {Link, useNavigate} from 'react-router-dom';
import {Row, Col, Card, CardBody, Button} from 'reactstrap';
import QuantitySelect from '../components/QuantitySelect';
import CartSummary from '../components/CartSummary';
import ConfirmModal from '../components/ConfirmModal';
import {money, toCents} from '../utils/money';

export default function CartPage({cart, setCart}) {
    const [flow, setFlow] = useState(null);
    const navigate = useNavigate();

    function confirmCancellation() {
        clearCart();
        setFlow('cancelled');
    }

    function finishOrder() {
        clearCart();
        setFlow(null);
        navigate('/menu');
    }

    function updateQuantity(id, quantity) {
        if (quantity < 1 || quantity > 5)
            return;
        setCart((current) =>
            current.map((item) => item.id === id ? {...item, quantity} : item));
    }

    function removeItem(id){
        let newCart = cart;
        newCart = newCart.filter((item) => item.id != id)
        setCart(newCart);
    }

    function clearCart(){
        setCart([])
    }

    return <>
        <p className="eyebrow">Quartermaster’s ledger</p>
        <h1>Your Cart</h1>

        {cart.length === 0 ?
            //EMPTY CART
            <div className="empty-cart">
                <p>Your cart is empty.</p>
                <Button tag={Link}
                        to="/menu"
                        color="primary">
                    Browse the Menu
                </Button>
            </div>

            :

            //NOT EMPTY CART
            <Row className="g-4 mt-1">
                <Col lg="8">
                    <div className="d-grid gap-3">
                        {cart.map((item) =>
                            <Card key={item.id}>
                                <CardBody className="cart-item">
                                    <div>
                                        <h2 className="h4">{item.name}</h2>
                                        <p>{money(toCents(item.price))} each</p>
                                    </div>
                                    <QuantitySelect id={`cart-quantity-${item.id}`}
                                                    name={item.name}
                                                    quantity={item.quantity}
                                                    onChange={(quantity) => updateQuantity(item.id, quantity)}
                                    />
                                    <div>
                                        <span className="small d-block">Line total</span>
                                        <strong>{money(toCents(item.price) * item.quantity)}</strong>
                                    </div>
                                    <Button color="secondary"
                                            onClick={() => removeItem(item.id)}
                                            aria-label={`Remove ${item.name}`}
                                    >
                                        Remove
                                    </Button>
                                </CardBody>
                            </Card>)
                        }
                    </div>
                </Col>

                <Col lg="4"><CartSummary cart={cart}/>
                    <div className="d-grid gap-2 mt-3">
                        <Button color="primary"
                                onClick={() => setFlow('submitted')}>
                            Submit Order</Button>
                        <Button color="secondary"
                                onClick={() => setFlow('cancel')}>
                            Cancel Order
                        </Button>
                    </div>
                </Col>
            </Row>
        }

        <ConfirmModal isOpen={flow === 'cancel'}
                      title="Cancel Order"
                      confirmText="Yes, Cancel Order"
                      onCancel={() => setFlow(null)}
                      onConfirm={confirmCancellation}
        >
            Are you sure you want to cancel your order?
        </ConfirmModal>

        <ConfirmModal isOpen={flow === 'submitted' || flow === 'cancelled'}
                      title="Thank You"
                      confirmText="Return to Menu"
                      onConfirm={finishOrder}
        >
            {flow === 'cancelled' ? 'Your order has been cancelled.' : 'Thank you! Your  order is complete.'}
        </ConfirmModal>
    </>;
}
