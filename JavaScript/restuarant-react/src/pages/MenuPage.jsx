import {useState} from 'react';
import {Row, Col} from 'reactstrap';
import menuItems from '../data/menuData.json';
import MenuFilter from '../components/MenuFilter';
import MenuItemCard from '../components/MenuItemCard';

export default function MenuPage({cart, setCart}) {
    const [category, setCategory] = useState('All');

    const visibleItems = menuItems.filter((item) => category === 'All' || item.category === category);

    function addToCart(item, quantity) {
        if (quantity < 1 || quantity > 5)
            return;

        setCart((current) => {
            const existingItem = current.find((entry) => entry.id === item.id);

            if (existingItem) {
                return current.map((entry) => {
                    if (entry.id === item.id) {
                        return {
                            ...entry,
                            quantity: Math.min(5, entry.quantity + quantity)
                        };
                    }
                    return entry;
                });
            }

            return [...current, { id: item.id, name: item.name, price: item.price, quantity }];
        });
    }

    return <>
        <p className="eyebrow">From the boiler galley</p>
        <h1>Field Rations</h1>
        <p>Fresh from the mess. Choose up to five of each item.</p>
        <MenuFilter category={category} setCategory={setCategory}/>
        <Row className="g-4">
            {visibleItems.map((item) =>
                <Col sm="6" lg="4" key={item.id}>
                    <MenuItemCard item={item}
                                  inCart={cart.find((entry) => entry.id === item.id)?.quantity || 0}
                                  onAdd={addToCart}
                    />
                </Col>)}
        </Row>
    </>;
}
