import {useEffect, useState} from 'react';
import {Link, Route, Routes, useLocation} from 'react-router-dom';
import {Container} from 'reactstrap';
import SiteNavbar from './components/SiteNavbar';
import HomePage from './pages/HomePage';
import MenuPage from './pages/MenuPage';
import ReservationsPage from './pages/ReservationsPage';
import CartPage from './pages/CartPage';

export default function App() {
    const [cart, setCart] = useState([]);
    const {pathname} = useLocation();

    useEffect(() => {
        const title = {
            '/': 'Home',
            '/menu': 'Menu',
            '/reservations': 'Reservations',
            '/cart': 'Cart'
        }[pathname] || 'Page not found';
        document.title = `${title} | Major McClellan’s Migrating Mechanical Mess`;
        window.scrollTo(0, 0);
    }, [pathname]);

    return <>
        <SiteNavbar cartCount={cart.reduce((sum, item) => sum + item.quantity, 0)}/>
        <Container tag="main" id="main-content" className="py-4 py-lg-5">
            <Routes>
                <Route path="/" element={<HomePage/>}/>
                <Route path="/menu" element={<MenuPage cart={cart} setCart={setCart}/>}/>
                <Route path="/reservations" element={<ReservationsPage/>}/>
                <Route path="/cart" element={<CartPage cart={cart} setCart={setCart}/>}/>
            </Routes>
        </Container>
        <footer className="site-footer">
            <Container>MMMMM · Hot meals. Fresh supplies. Morale.</Container>
        </footer>
    </>;
}
