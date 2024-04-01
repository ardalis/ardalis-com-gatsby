require("prismjs/plugins/line-numbers/prism-line-numbers.css")
require("prismjs/plugins/command-line/prism-command-line.css")
require("prismjs/themes/prism-okaidia.css")


const loadAdScript = () => {
    // Define the container for the ad if it doesn't already exist
    const adContainerId = 'ad-container';

    // Try to get the existing ad container
    let adContainer = document.getElementById(adContainerId);
    if (!adContainer) {
        // If it doesn't exist, create a new container div
        adContainer = document.createElement('div');
        adContainer.id = adContainerId;
        adContainer.style.padding = '8px';
        adContainer.style.marginLeft = '10px';

        const sidebar = document.getElementById('sidebar');
        if (sidebar) {
            // Find all div elements inside the sidebar
            const divsInSidebar = sidebar.getElementsByTagName('div');

            // Check if there are already at least two div elements to insert after
            if (divsInSidebar.length >= 2) {
                // Insert the adContainer after the second div (to make it the third div in the sidebar)
                divsInSidebar[1].insertAdjacentElement('afterend', adContainer);
            } else {
                // If there are less than two divs, just append the adContainer at the end of the sidebar
                sidebar.appendChild(adContainer);
            }
        } else {
            console.warn('Sidebar element not found.');
        }
    }

    // Ensure the container is empty before adding a new ad script
    adContainer.innerHTML = '';

    // Create the new script element
    const script = document.createElement('script');
    script.async = true;
    script.type = 'text/javascript';
    script.src = "//cdn.carbonads.com/carbon.js?serve=CWYIE53N&placement=ardaliscom&format=cover";
    script.id = '_carbonads_js';

    // Append the script to the ad container
    adContainer.appendChild(script);
};


exports.onRouteUpdate = () => {
    console.log('Congrats! You have found the secret treasure. 😉');
    loadAdScript();
};
