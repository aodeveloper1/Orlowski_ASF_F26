import {Link} from 'react-router-dom';
import {Row, Col, Button, Container} from 'reactstrap';
import Image from '../components/Image.jsx'

export default function HomePage() {
    return <Row className="align-items-center g-5 hero-section">
        <Col lg="6">
            <p className="eyebrow">Provisions from above</p>
            <h1>Major McClellan’s Migrating Mechanical Mess</h1>
            <p className="lead my-4">Hot meals. Fresh supplies. Morale. <strong>MMMMM satisfaction.</strong></p>
            <p>The airship galley is open. Order your rations or schedule a delivery to the front lines.</p>

            <Container fluid className="d-flex flex-wrap gap-3 mt-4 p-0">
                <Button tag={Link} to="/menu" color="primary">Explore the Menu</Button>
                <Button tag={Link} to="/reservations" color="secondary">Schedule your chow delivery</Button>
            </Container>
        </Col>

        <Col lg="6">
            <Image filename="MMMMM badge.png"
                 alt="Major McClellan’s airship mess hall badge"
                 className="hero-art"
            />
        </Col>
    </Row>;
}
