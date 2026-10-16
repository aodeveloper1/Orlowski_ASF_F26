export default function Image({ filename, alt, className = '' }) {
    return (
        <img
            src={new URL(`../assets/images/${filename}`, import.meta.url).href}
            alt={alt}
            className={`my-image ${className}`}
        />
    );
}