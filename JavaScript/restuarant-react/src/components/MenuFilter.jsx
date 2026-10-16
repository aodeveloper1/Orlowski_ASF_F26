import {FormGroup, Label, Input} from 'reactstrap';

export default function MenuFilter({category, setCategory}) {
    return <FormGroup className="menu-filter">
                <Label for="category">Choose your rations</Label>
                <Input id="category"
                       type="select"
                       value={category}
                       onChange={(event) => setCategory(event.target.value)}
                >
                    {['All', 'Breakfast', 'Lunch', 'Dinner'].map((value) => <option key={value}>{value}</option>)}
                </Input>
            </FormGroup>;
}