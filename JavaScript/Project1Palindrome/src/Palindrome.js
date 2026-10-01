function isPalindrome(str) {

    if(typeof str !== 'string') return false;

    str = str.toLowerCase();
    str = str.replace(/[^a-zA-Z0-9]/g, '');

    let left = 0;
    let right = str.length-1;

    while(true){
        if (right <= left){
            return true;
        }
        if (str[left] !== str[right]){
            return false;
        }
        left++;
        right--;
    }
}

module.exports = isPalindrome;