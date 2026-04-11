# Design System: Quiet Luxury Spirituality

## 1. Overview & Creative North Star: "The Celestial Nocturne"
This design system moves away from the aggressive, high-contrast patterns of modern productivity apps and enters the realm of **The Celestial Nocturne**. The Creative North Star is an experience that feels like an intentional, high-end sanctuary—a digital silk robe for the mind.

We break the "template" look by rejecting rigid, boxy structures. Instead, we use **intentional asymmetry**, **ethereal layering**, and **tonal depth** to guide the user. The interface should feel as though it is emerging from a soft mist, utilizing "breathable" whitespace and delicate typography to establish a sense of safety and intimacy. This is not a tool; it is a ritual.

## 2. Colors: Moonlight & Mist
Our palette is rooted in the depth of a midnight sky, lifted by pearlescent highlights and starlight.

### Surface Hierarchy & Nesting
To achieve a "Quiet Luxury" feel, we prohibit 1px solid borders for sectioning (**The No-Line Rule**). Boundaries are defined through background shifts or tonal transitions.
- **Surface (Base):** `#11131c`. The deep midnight canvas.
- **The Nesting Principle:** Use `surface-container-low` (`#191b24`) for secondary regions and `surface-container-high` (`#282933`) for interactive elements. This creates a physical stacking effect—like layers of fine paper—rather than a flat grid.
- **The Glass & Gradient Rule:** For floating elements or primary CTAs, use `surface-bright` (`#373943`) with a `backdrop-blur` of 20px-40px. 
- **Signature Textures:** Apply a subtle radial gradient from `primary-container` (`#1b1137`) to `surface` in the background of screens to mimic a distant nebula or "moonlight glow."

| Token | Hex | Role |
| :--- | :--- | :--- |
| `primary` | `#cdbff0` | Pearlescent Purple (Hero Actions/Accents) |
| `secondary` | `#b5c8df` | Misty Silver (Supportive Elements) |
| `surface` | `#11131c` | Midnight Base (The Night Sky) |
| `on-surface` | `#e1e1ef` | Starlight White (High-Contrast Text) |
| `outline-variant` | `#45464c` | Ghost Border (Only if necessary) |

## 3. Typography: Editorial Intimacy
We utilize a high-contrast pairing of **Noto Serif** for soul and **Manrope** for clarity. This evokes the feeling of a premium printed journal.

*   **Display & Headlines (Noto Serif):** Used for dream titles and "Aha!" moments. The serif adds a timeless, human touch that counters the coldness of digital screens.
*   **Body & Titles (Manrope):** Used for navigation and interpretation text. Manrope’s geometric but soft curves provide a modern, sophisticated legibility.
*   **Scale:** Use `display-lg` (3.5rem) sparingly to create dramatic, asymmetrical entry points. Set `body-lg` (1rem) with a generous `1.6` line-height to ensure the reading experience feels unhurried.

## 4. Elevation & Depth: Tonal Layering
Traditional shadows and borders are too "corporate." In this system, depth is organic.

*   **The Layering Principle:** Place a `surface-container-lowest` card on a `surface-container-low` section. The subtle contrast (e.g., `#0c0e17` vs `#191b24`) creates a soft, natural lift.
*   **Ambient Shadows:** If a card must "float" (e.g., a modal), use a wide-spread shadow (Blur: 40px) with 6% opacity using a tint of `primary-container`. This mimics the way light diffuses through mist.
*   **The Ghost Border:** If a boundary is needed for accessibility, use the `outline-variant` at **15% opacity**. It should be felt, not seen.
*   **Glassmorphism:** Navigation bars and floating action buttons must use `surface` colors at 70% opacity with a high `backdrop-filter: blur(25px)`. This allows the "glow" of background gradients to bleed through, maintaining a sense of ethereal continuity.

## 5. Components

### Cards & Lists
*   **The Rule:** No divider lines. Period.
*   **Execution:** Use vertical spacing (24px - 32px) and subtle shifts in `surface-container` tiers to separate list items. Cards should have an `xl` (1.5rem) corner radius to feel soft to the touch.

### Buttons
*   **Primary:** A soft gradient from `primary` to `primary-fixed-dim`. Text is `on-primary-fixed`. No harsh shadows.
*   **Secondary:** Ghost style. No background, only a "Ghost Border" at 20% opacity.
*   **Tertiary:** Text-only in `secondary` color, used for low-emphasis actions like "Cancel."

### Input Fields
*   **Style:** Minimalist. A single `outline-variant` line at 20% opacity at the bottom of the field, or a slightly darker `surface-container-lowest` background. Labels should use `label-sm` in `on-surface-variant`.

### Signature Component: The Dream Orb
*   **Context:** Used for "Analyze" or "Journal" triggers.
*   **Design:** A circular element using a `primary` to `secondary` mesh gradient with a soft outer glow (`box-shadow: 0 0 20px primary_container`). It should appear to pulse gently.

---

## 6. Do's and Don'ts

### Do
*   **DO** use ample white space. If a layout feels "full," remove an element.
*   **DO** use asymmetrical layouts (e.g., a headline offset to the left with a floating image slightly to the right).
*   **DO** use soft, flowing micro-animations (300ms-500ms ease-in-out) that mimic breathing.

### Don't
*   **DON'T** use pure black (`#000000`) or pure white (`#FFFFFF`). Use our midnight and starlight tokens.
*   **DON'T** use generic iconography. Icons must be thin-stroke (1px) and delicately rounded.
*   **DON'T** use "Gamification" elements like bright badges or loud progress bars. Luxury is quiet; progress is a journey, not a race.