(function(){
  function initBlueskyShare(){
    document.querySelectorAll('.bsky-share-link').forEach(function(link){
      if(link.dataset.bskyProcessed) return;
      link.dataset.bskyProcessed = '1';
      var title = link.getAttribute('data-bsky-title') || document.title;
      var tag = link.getAttribute('data-bsky-tag') || '';
      var url = link.getAttribute('data-bsky-url') || window.location.href;
      var text = (title + tag + ' - ' + url).trim();
      var encoded = encodeURIComponent(text);
      link.href = 'https://bsky.app/intent/compose?text=' + encoded;
      link.target = '_blank';
      link.rel = 'noopener';

      link.addEventListener('click', function(ev){
        if(navigator.share){
          // Provide a nicer mobile experience via Web Share API
            ev.preventDefault();
            navigator.share({ text: title + tag, url: url })
              .catch(function(){ /* ignore user cancellations */ });
        }
      });
    });
  }
  if(document.readyState === 'loading'){
    document.addEventListener('DOMContentLoaded', initBlueskyShare);
  } else {
    initBlueskyShare();
  }
})();
