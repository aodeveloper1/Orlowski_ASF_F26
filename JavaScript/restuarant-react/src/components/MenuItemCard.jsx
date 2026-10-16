import {useState} from 'react';
import {Card, CardBody, CardTitle, CardText, Button, Badge} from 'reactstrap';
import Image from './Image';
import QuantitySelect from './QuantitySelect';
import {money, toCents} from '../utils/money';

export default function MenuItemCard({item, inCart, onAdd}) {
    const [quantity, setQuantity] = useState(1);

    return <Card className="menu-card h-100">
        <Image filename={item.img} alt={item.name}/>

        <CardBody className="d-flex flex-column">
            <div className="d-flex justify-content-between gap-2 mb-3">
                <Badge
                color="secondary">{item.category}</Badge>
                <strong>{money(toCents(item.price))}</strong>
            </div>

            <CardTitle tag="h2" className="h4">
                {item.name}
            </CardTitle>

            <CardText>{item.description}</CardText>

            <div className="mt-auto">
                <p className="small">{inCart} of 5 in cart</p>
                <div className="d-flex align-items-end gap-3">
                    <QuantitySelect id={`quantity-${item.id}`}
                                    name={item.name}
                                    quantity={quantity}
                                    onChange={setQuantity}
                                    disabled={inCart === 5}/>
                    <Button color="primary"
                            disabled={inCart === 5}
                            onClick={() => onAdd(item, quantity)}
                            aria-label={`Add ${item.name} to cart`}
                    >
                        {inCart === 5 ? 'Limit reached' : 'Add to Cart'}
                    </Button>
                </div>
            </div>
        </CardBody>
    </Card>;
}
