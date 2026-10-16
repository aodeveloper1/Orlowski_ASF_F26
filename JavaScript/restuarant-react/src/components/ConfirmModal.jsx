import {Modal, ModalHeader, ModalBody, ModalFooter, Button} from 'reactstrap';

export default function ConfirmModal({isOpen, title, children, onConfirm, confirmText = 'Continue', onCancel}) {
    return <Modal isOpen={isOpen}
                  toggle={onCancel}
                  backdrop="static"
                  keyboard={Boolean(onCancel)}
                  centered
                  labelledBy="confirmation-title"
            >
                <ModalHeader id="confirmation-title" toggle={onCancel}>
                    {title}
                </ModalHeader>
                <ModalBody>{children}</ModalBody>
                <ModalFooter>
                    {onCancel && <Button color="secondary" onClick={onCancel}>Keep Order</Button>}
                    <Button color="primary" onClick={onConfirm}>{confirmText}</Button>
                </ModalFooter>
            </Modal>;
}
