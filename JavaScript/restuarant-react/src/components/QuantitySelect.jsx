import {Input, Label} from 'reactstrap';

export default function QuantitySelect({id, name, quantity, onChange, disabled = false}) {
    return <div className="quantity-select">
        <Label for={id}>
            Quantity <span className="visually-hidden">for {name}</span>
        </Label>
        <Input id={id}
               type="select"
               value={quantity}
               disabled={disabled}
               onChange={(event) => onChange(Number(event.target.value))}
        >
            {[1, 2, 3, 4, 5].map((value) =>
                <option key={value} value={value}>{value}</option>
            )}
        </Input>
    </div>;
}
