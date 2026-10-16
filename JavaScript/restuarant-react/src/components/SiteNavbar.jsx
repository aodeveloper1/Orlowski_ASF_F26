import {useState} from 'react';
import {Link, NavLink as RouterNavLink} from 'react-router-dom';
import {Navbar, NavbarBrand, NavbarToggler, Collapse, Nav, NavItem, NavLink, Container} from 'reactstrap';
import Image from './Image';

export default function SiteNavbar({cartCount}) {
    const [isOpen, setIsOpen] = useState(false);

    return <Navbar container={false}
                   dark expand="lg"
                   className="site-navbar"
                   aria-label="Main navigation"
            >
                <Container>
                    <NavbarBrand tag={Link} to="/"
                                 onClick={() => setIsOpen(false)}>
                        <Image filename="favicon.png" alt="MMMMM Favicon" className="navbar-brand"/>
                        <span className="d-none d-sm-inline">Major McClellan’s Migrating Mechanical Mess</span>
                        <span className="d-sm-none">MMMMM</span>
                    </NavbarBrand>
                    <NavbarToggler aria-controls="main-nav"
                                   aria-expanded={isOpen}
                                   aria-label="Toggle navigation"
                                   onClick={() => setIsOpen(!isOpen)}
                    />
                    <Collapse isOpen={isOpen} navbar id="main-nav">
                        <Nav navbar className="ms-auto">
                        {[['/', 'Home'],
                            ['/menu', 'Menu'],
                            ['/reservations', 'Reservations'],
                            ['/cart', `Cart (${cartCount})`]].map(([to, label]) =>
                            <NavItem key={to}>
                                <NavLink tag={RouterNavLink}
                                         to={to}
                                         end={to === '/'}
                                         onClick={() => setIsOpen(false)}>
                                    {label}
                                </NavLink>
                            </NavItem>)}
                        </Nav>
                    </Collapse>
                </Container>
            </Navbar>;
}
