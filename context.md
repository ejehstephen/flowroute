 use clean architecture and riverpod for state management, make sure u seperate the ui from the business logic. and make sure u use the best practices for clean architecture.and break them down into components. or modules as much as possible.

 and take them one after te other and wait for my approval before moving to the next one. i will be giving you the approval after i have checked the code. and giving you the next ui design to work on.

 
 a simple, AI-powered traffic assistant that helps users detect traffic on any road, ask live questions, and receive optimized route suggestions.

The UI should be aesthetically pleasing, minimal, smooth, and visually similar to a premium music app, where the background dynamically adapts to the dominant color of the current card, road, route, or traffic state. adaptive screens, Google Maps clarity.

The user flow for FlowRoute AI is designed to be intuitive and dynamic, guiding users through traffic detection, route optimization, and community interaction. Here’s a breakdown of the typical user journey:

 App Summary

FlowRoute AI is a community-driven + AI-powered traffic assistant.

Users can:

Check live traffic conditions (Heavy / Medium / Light)

Report traffic easily

Ask public community questions (e.g., “Is there traffic at Lekki Phase 1?”)

Ask private AI questions (if signed-in)

Save personal routes

Receive AI route optimization to avoid traffic

View maps with traffic overlays

Use the app as a guest or with an account

Businesses can integrate the service via API (bonus screen).

Initial Access & Onboarding:

Splash Screen: The user first sees the FlowRoute AI logo and tagline, introducing the app.
Onboarding Screens (3 slides): The user is guided through the app's core features: "Check Traffic Instantly," "Ask Community or AI," and "Get the Best Routes, Always." Each slide uses visuals and adaptive backgrounds to highlight functionality.
Authentication Screens (Login/Signup): After onboarding, users can choose to "Continue as Guest" or proceed with "Login" or "Signup" (which includes social login options).
Guest User Flow:

From the Login/Signup screen, a guest user can tap "Continue as Guest" to immediately access the core features without creating an account. They can check live traffic, ask community questions, and view maps. Personalized features like saving routes or asking private AI questions would be unavailable until they sign up.
Core App Interaction (Signed-in or Guest):

Home Screen (Main Dashboard): This is the central hub. Users see a search bar, a live traffic map preview, and quick traffic cards (Heavy/Medium/Light) with dynamically adapting backgrounds. They can easily "Report Traffic" or "Ask Community."
Traffic Map Screen: Tapping on the map preview or selecting "Map" from the navigation takes the user to a full-screen map with detailed traffic overlays. Users can apply quick filters for accidents, roadblocks, or user reports and can initiate a "Show Best Route to Destination."
Asking Questions & AI Interaction:

Ask a Question Screen: From the Home screen or navigation, users can access this screen to pose a question. They choose to "Ask Community" or "Ask FlowRoute AI" and can attach location pins or photos. The background adapts to the traffic level of the selected location.
AI Chat Assistant Screen: If "Ask FlowRoute AI" is selected, or if navigating directly to "Chat," users enter a modern chat interface. They can type or use voice input, attach locations, and leverage AI suggestion chips. The AI provides text, route suggestions, traffic summaries, and map preview cards.
Community Q&A Screen: If "Ask Community" is selected, or if navigating directly to "Community," users see a list of public traffic questions. They can view question details and contribute public replies, with AI-assisted reply cards available.
Personalized Features (Signed-in Users):

Saved Routes Screen: Signed-in users can access this screen via navigation to view their "Saved Routes." Each route card shows the name, estimated travel time, and current traffic level, with its background dynamically adapting to the traffic color.
Route Details Screen: Tapping a saved route or a suggested route from the AI/map leads to this screen. It displays a detailed map of the route with color-coded traffic segments, estimated arrival time, alternative routes, and AI suggestions for optimizing travel.
Profile & Settings Screen: Accessible via navigation, this screen allows signed-in users to manage their avatar, edit their profile, organize saved locations, configure notification settings, toggle privacy mode for private questions, and log out.
Business Integration (Optional):

Business API Integration Screen: (This would be an additional screen, potentially accessible from the Profile & Settings, for business users interested in integrating FlowRoute AI's traffic intelligence via API.)
This flow ensures a smooth transition between different functionalities, leveraging the color-adaptive design and consistent navigation to provide a premium and user-friendly experience.

Here are the colors for each screen base on the ui design:

Splash Screen

Background: Soft gradient, likely a cool-toned blend (e.g., subtle blue to light purple, or muted teal to a light grey-blue) to evoke a techy, intelligent feel.
Logo/Text: White or very light grey for high contrast against the gradient.
Onboarding Screens (3 slides)

Background: Color-adaptive, with soft gradients. While not tied to live traffic yet, each slide's background could subtly reflect the theme:
"Check Traffic Instantly": Perhaps a soft, calm blue-green gradient.
"Ask Community or AI": A more interactive, possibly light purple or soft orange gradient.
"Get the Best Routes, Always": A forward-moving, perhaps bright yet soft yellow or light green gradient.
Illustrations/Icons: Muted, modern colors that complement the background gradient.
Text: Dark grey or black for readability on light backgrounds.
Authentication Screens (Login, Signup, Forgot Password)

Background: Soft, calming gradients, similar to the onboarding, possibly a consistent light blue-purple or soft grey gradient to maintain a neutral, welcoming tone before core app interaction.
Full-screen Cards/Input Fields: Predominantly white or very light grey, with soft shadows.
Text: Dark grey/black for input fields and labels.
Buttons (Social Login/Primary Action): Brand colors for Google/Apple, or a primary app gradient (e.g., blue/purple) for "Login/Signup" buttons.
"Continue as Guest" Button: Outline button with app accent color text.
Home Screen (Main Dashboard)

Dynamic Background: The most prominent color will be a soft, full-screen gradient that adapts to the dominant traffic card in focus:
Heavy Traffic Focus: Dominant soft Red gradient (e.g., deep rose to lighter coral).
Medium Traffic Focus: Dominant soft Yellow/Orange gradient (e.g., warm goldenrod to light peach).
Light Traffic Focus: Dominant soft Green gradient (e.g., calming emerald to light mint).
Search Bar, Buttons (Ask AI, Report Traffic, Ask Community): White or very light backgrounds with dark text/icons, allowing them to pop against the adaptive background.
Quick Traffic Cards: Their own backgrounds will be the specific red, yellow, or green tones, rounded with soft shadows.
Map Preview: Standard map colors (greys, blues, greens) with traffic overlays.
Traffic Map Screen

Dynamic Background/Tone: The overall visual tone of the map and surrounding UI elements will subtly adapt to the major traffic color in the area:
If the area is mostly heavy traffic, the UI's subtle elements might lean towards muted reds/oranges.
If mostly light traffic, muted greens/blues.
Map Overlay: Bright, distinct Red, Yellow, Green for traffic segments.
Bottom Sheet, Filters, Buttons: White or light grey backgrounds with rounded edges and soft shadows, ensuring legibility against the map.
Text/Icons: Dark grey/black for readability.
AI Chat Assistant Screen

Dynamic Background: Color-adaptive, likely a soft gradient that could subtly change based on the nature of the AI's response (e.g., if it suggests a clear route, a calming green-blue; if it warns of heavy traffic, a muted yellow-orange).
Chat Bubbles:
User: App's primary accent color (e.g., blue/purple gradient fill).
AI: Lighter, neutral fill (e.g., very light grey or off-white).
Input Bar: White or light grey with rounded edges.
AI Suggestion Chips: Soft, subtle fills (e.g., light grey, light blue) with dark text.
Community Q&A Screen

Background: Neutral, clean background (e.g., very light grey or off-white, or a subtle cool gradient) to make the question cards stand out.
Question Cards: White or light grey rounded cards with soft shadows.
Dynamic Borders on Cards: Red, Yellow, Green borders/accents based on traffic severity mentioned in the question.
Text: Dark grey/black for questions, user info.
Traffic Badges: Solid Red, Yellow, Green fills with white text.
Ask a Question Screen

Dynamic Background: Color-adaptive soft gradient based on the selected location's traffic level (e.g., if the pin is in heavy traffic, the background will be a soft red gradient).
Input UI/Buttons: White or light grey rounded elements with soft shadows for input fields and action buttons ("Ask Community," "Ask FlowRoute AI").
Attach Icons: Muted, fluent icons for location pin and photo.
Saved Routes Screen (For Logged-in Users)

Background: Neutral, clean background (similar to Community Q&A).
Saved Route Cards: White or light grey rounded cards with soft shadows.
Dynamic Background for Each Card: The background of each individual card will be a soft Red, Yellow, or Green gradient to reflect the current traffic level of that specific saved route.
Text: White or light text for route details on adaptive card backgrounds.
Route Details Screen

Map: Standard map colors with distinct Red, Yellow, Green traffic segments.
Information Panels/AI Suggestions: White or very light grey rounded cards/panels with soft shadows for estimated arrival time, alternative routes, and AI suggestions.
Background behind map (if any): Subtle, dark grey or deep blue if the map doesn't fill the entire screen, to allow the map to be the focus.
Profile & Settings Screen

Background: Clean, neutral background (e.g., very light grey or off-white, or a subtle cool gradient) for a professional and calm user experience.
User Avatar/Cards/List Items: White or light grey rounded elements with soft shadows.
Text/Icons: Dark grey/black for profile details, settings options, and icons.
Logout Button: A distinct color, perhaps a subtle red accent, to signify a final action.
Business API Integration Screen

Background: Prominent Blue/Purple gradient, giving it a professional, tech-focused, and slightly different feel from the main app's traffic-adaptive colors.
Call to Action/Buttons: White or light grey rounded buttons, or primary app gradient buttons that pop against the background.
Text/Documentation Preview: White or light text against the dark gradient, with code snippets potentially having their own syntax highlighting colors.


Animation Principles for Adaptive Backgrounds base on the ui design
Smooth, Gradual Transitions (Crossfade/Soft Morph):

Principle: Instead of an abrupt snap, the background color should seamlessly fade or morph from its current state to the new dominant color. This is typically achieved with a crossfade or a soft color interpolation.
Effect: When a new traffic card comes into focus (e.g., from green to red), the entire screen's background gradient would gently transform. It wouldn't just swap; you'd see the green tones slowly give way to the red tones.
Duration: The transition duration would be carefully tuned – not too fast to be jarring, not too slow to feel sluggish. Around 300-500ms often feels natural and "smooth."
Ease-in/Ease-out (Fluid Motion):

Principle: Animations should not have a linear speed. They should start and end softly, accelerating in the middle (ease-out at the beginning, ease-in at the end).
Effect: When the color shift begins, it would accelerate smoothly, reach its peak change, and then decelerate as it settles into the new color. This makes the animation feel much more organic and less robotic.
Feeling: Contributes significantly to the "smooth" and "fluid" aspect you're looking for, making the app feel high-quality.
Gradient Interpolation (Dynamic Gradients):

Principle: When transitioning between two different color states (e.g., green to red), it's not just the primary color that shifts, but the entire gradient. The starting and ending points of the gradient, and the colors themselves, should all interpolate smoothly.
Effect: If the background is a "mint green to emerald" gradient, and it needs to become a "light coral to deep rose" gradient, the animation engine would smoothly blend between these two gradient definitions, not just the single dominant color.
Depth & Richness: Maintains the gradient's depth and visual richness throughout the transition, preventing a momentary flat appearance.
Subtle Background Element Motion (Parallax/Subtle Waves):

Principle: To enhance the "futuristic" and "premium" feel, the gradients themselves might have a very subtle, slow-moving animation beneath the main UI elements.
Effect: Imagine a very slow, almost imperceptible "breathing" or "pulsing" motion within the gradient, or a gentle, slow parallax shift if the user scrolls. This adds a layer of sophistication without being distracting.
Energy: Gives the background a sense of living energy, even when the dominant color isn't changing.
Contextual Speed and Intensity:

Principle: The urgency of the traffic state could subtly influence the animation.
Effect: A transition to a "heavy traffic" red background might be slightly quicker or have a touch more "snap" than a transition to a "light traffic" green background, which could be more leisurely. This adds a subtle psychological layer to the feedback.