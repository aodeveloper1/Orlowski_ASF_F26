import {useState} from 'react';
import {useForm} from 'react-hook-form';
import {yupResolver} from '@hookform/resolvers/yup';
import * as yup from 'yup';

import {
    Row, Col, Card, CardBody, Button
} from 'reactstrap';

import ConfirmModal from '../components/ConfirmModal';
import Image from '../components/Image';

const seatingOptions = ['Air Drop Only', 'Cold Rations Only', 'Full Service',];

const schema = yup.object({
    name: yup
        .string()
        .trim()
        .required('Enter your name.')
        .max(20, 'Use 20 characters or fewer.'),

    email: yup
        .string()
        .trim()
        .required('Enter your email.')
        .email('Enter a valid email address.'),

    partySize: yup
        .number()
        .typeError('Choose a party size.')
        .required('Choose a party size.')
        .integer('Choose a whole number.')
        .min(1, 'Party size must be at least 1.')
        .max(8, 'Party size cannot exceed 8.'),

    date: yup
        .string()
        .required('Choose a date.'),

    time: yup
        .string()
        .required('Choose a time.'),

    seating: yup
        .string()
        .required('Choose a seating preference.')
        .oneOf(seatingOptions, 'Choose a seating preference.'),

    dietaryNotes: yup
        .string()
        .max(30, 'Use 30 characters or fewer.'),

    newsletter: yup
        .boolean(),
});

const defaultValues = {
    name: '',
    email: '',
    partySize: '',
    date: '',
    time: '',
    seating: '',
    dietaryNotes: '',
    newsletter: false,
};

export default function ReservationsPage() {
    const [confirmation, setConfirmation] = useState('');

    const {
        register, handleSubmit, reset, formState: {errors},
    } = useForm({
        resolver: yupResolver(schema), defaultValues,
    });

    function onSubmit(data) {
        setConfirmation(`Thank you, ${data.name}! Your reservation request for ` + `${data.partySize}
         on ${data.date} at ${data.time} is confirmed.`);

        reset(defaultValues);
    }

    return (<Row className="g-4">
            <Col lg="7">
                <Card>
                    <CardBody className="p-4">
                        <h1>Schedule Today</h1>

                        <p>
                            Has your unit outpaced its organic logistics capabilities?
                            Reserve your delivery today. Requests are subject to
                            campaign plan requirements and General approval.
                        </p>

                        <p className="small">
                            All fields are required except dietary notes and newsletter.
                        </p>


                        <form noValidate onSubmit={handleSubmit(onSubmit)}>
                            <div className="mb-3">
                                <label htmlFor="name" className="form-label">
                                    Name
                                </label>
                                <input
                                    id="name"
                                    type="text"
                                    autoComplete="name"
                                    className="form-control"
                                    {...register('name')}
                                />
                                {errors.name && (
                                    <p className="invalid-feedback d-block">
                                        {errors.name.message}
                                    </p>
                                )}
                            </div>

                            <div className="mb-3">
                                <label htmlFor="email" className="form-label">
                                    Email
                                </label>
                                <input
                                    id="email"
                                    type="email"
                                    autoComplete="email"
                                    className="form-control"
                                    {...register('email')}
                                />
                                {errors.email && (
                                    <p className="invalid-feedback d-block">
                                        {errors.email.message}
                                    </p>
                                )}
                            </div>

                            <div className="mb-3">
                                <label htmlFor="partySize" className="form-label">
                                    Party Size
                                </label>
                                <select
                                    id="partySize"
                                    className="form-select"
                                    {...register('partySize')}
                                >
                                    <option value="">Choose a number</option>
                                    {[1, 2, 3, 4, 5, 6, 7, 8].map((number) => (
                                        <option key={number} value={number}>
                                            {number}
                                        </option>
                                    ))}
                                </select>
                                {errors.partySize && (
                                    <p className="invalid-feedback d-block">
                                        {errors.partySize.message}
                                    </p>
                                )}
                            </div>

                            <div className="mb-3">
                                <label htmlFor="date" className="form-label">
                                    Date
                                </label>
                                <input
                                    id="date"
                                    type="date"
                                    className="form-control"
                                    {...register('date')}
                                />
                                {errors.date && (
                                    <p className="invalid-feedback d-block">
                                        {errors.date.message}
                                    </p>
                                )}
                            </div>

                            <div className="mb-3">
                                <label htmlFor="time" className="form-label">
                                    Time
                                </label>
                                <input
                                    id="time"
                                    type="time"
                                    className="form-control"
                                    {...register('time')}
                                />
                                {errors.time && (
                                    <p className="invalid-feedback d-block">
                                        {errors.time.message}
                                    </p>
                                )}
                            </div>

                            <fieldset className="mb-3">
                                <legend className="h6">Seating Preference</legend>

                                {seatingOptions.map((option, index) => (
                                    <div className="form-check" key={option}>
                                        <input
                                            id={`seating-${index}`}
                                            type="radio"
                                            value={option}
                                            className="form-check-input"
                                            {...register('seating')}
                                        />
                                        <label
                                            htmlFor={`seating-${index}`}
                                            className="form-check-label"
                                        >
                                            {option}
                                        </label>
                                    </div>
                                ))}

                                {errors.seating && (
                                    <p className="invalid-feedback d-block">
                                        {errors.seating.message}
                                    </p>
                                )}
                            </fieldset>

                            <div className="mb-3">
                                <label htmlFor="dietaryNotes" className="form-label">
                                    Dietary Notes (optional, max 30 characters)
                                </label>
                                <textarea
                                    id="dietaryNotes"
                                    rows={3}
                                    className="form-control"
                                    {...register('dietaryNotes')}
                                />
                                {errors.dietaryNotes && (
                                    <p className="invalid-feedback d-block">
                                        {errors.dietaryNotes.message}
                                    </p>
                                )}
                            </div>

                            <div className="form-check mb-4">
                                <input
                                    id="newsletter"
                                    type="checkbox"
                                    className="form-check-input"
                                    {...register('newsletter')}
                                />
                                <label htmlFor="newsletter" className="form-check-label">
                                    Subscribe to the newsletter (optional)
                                </label>
                            </div>

                            <div className="d-flex flex-wrap gap-2">
                                <Button type="submit" color="primary">
                                    Transmit Reservation Wire
                                </Button>

                                <Button type="button" color="secondary"
                                        onClick={() => reset(defaultValues)}>
                                    Clear
                                </Button>
                            </div>
                        </form>
                    </CardBody>
                </Card>
            </Col>

            <Col lg="5">
                <Image
                    filename="MMMMM concept.png"
                    alt="MMMMM airship delivering rations to soldiers"
                    className="reservation-art"
                />
            </Col>

            <ConfirmModal
                isOpen={Boolean(confirmation)}
                title="Reservation Confirmed"
                confirmText="Back to Reservations"
                onConfirm={() => setConfirmation('')}
            >
                {confirmation}
            </ConfirmModal>
        </Row>);
}