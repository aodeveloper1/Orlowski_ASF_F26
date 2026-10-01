const isPalindrome = require('../src/Palindrome')

describe("Simple test cases", () => {

        test('Jest is working', () => {
            expect(1 + 1).toBe(2);
        });

       describe("should be a palindrome" , () => {

           test('empty string should be a palindrome', () => {
               expect(isPalindrome("")).toBe(true);
           })

           test('single character should be a palindrome', () => {
               expect(isPalindrome("a")).toBe(true);
           })

           test('basic cases should be palindrome', () => {
               expect(isPalindrome("bob")).toBe(true);
           })


           test("palindrome should ignore punctuation", () => {
               expect(isPalindrome("Madam I'm Adam.")).toBe(true);
               expect(isPalindrome("Red rum, sir, is murder.")).toBe(true);
           })

       })

        describe("should not be identified as a palindrome", () => {

            test('two different letter characters should not be a palindrome', () => {
                expect(isPalindrome("ab")).toBe(false);
            })

            test('basic cases should not be palindrome', () => {
                expect(isPalindrome("apple")).toBe(false);
            })

            test("palindromes should not be case-sensitive", () => {
                expect(isPalindrome("Racecar")).toBe(true);
            })

            test("non-string input should not be palindrome", () => {
                expect(isPalindrome(123)).toBe(false);
                expect(isPalindrome(null)).toBe(false);
                expect(isPalindrome(undefined)).toBe(false);
                expect(isPalindrome({})).toBe(false);
                expect(isPalindrome(true)).toBe(false);
                expect(isPalindrome([])).toBe(false);
                expect(isPalindrome(12.22)).toBe(false);
            })
        })
    }
)

describe("Advanced test cases from wikipedia", () => {

        test("advacnced test cases should be palindrome", () => {
            expect(isPalindrome("Able was I ere I saw Elba")).toBe(true);
            expect(isPalindrome("A dog! A panic in a pagoda!")).toBe(true);
            expect(isPalindrome("Ah, Satan sees Natasha")).toBe(true);
            expect(isPalindrome("A man, a plan, a canal – Panama!")).toBe(true);
            expect(isPalindrome("A man? A prisoner! A cage? Iron! Did Noriega care? No, sir! Panama!")).toBe(true);
            expect(isPalindrome("A Toyota")).toBe(true);
            expect(isPalindrome("A Toyota's a Toyota")).toBe(true);
            expect(isPalindrome("Dennis sinned")).toBe(true);
            expect(isPalindrome("Dennis and Edna sinned")).toBe(true);
            expect(isPalindrome("Doc, note: I dissent. A fast never prevents a fatness. I diet on cod")).toBe(true);
            expect(isPalindrome("Do geese see God?")).toBe(true);
            expect(isPalindrome("Do nine men Interpret? Nine men I nod")).toBe(true);
            expect(isPalindrome("Drab as a fool, aloof as a bard")).toBe(true);
            expect(isPalindrome("Drab as a fool, as aloof as a bard")).toBe(true);
            expect(isPalindrome("Draw, o coward!")).toBe(true);
            expect(isPalindrome("Egad, a base tone denotes a bad age")).toBe(true);
            expect(isPalindrome("God, a red nugget, a fat egg under a dog")).toBe(true);
            expect(isPalindrome("Go hang a salami, I'm a lasagna hog")).toBe(true);
            expect(isPalindrome("I, man, am Regal, a German am I")).toBe(true);
            expect(isPalindrome("If I had a hi-fi")).toBe(true);
            expect(isPalindrome("Lewd did I live & evil I did dwel")).toBe(true);
            expect(isPalindrome("Lewd did I live, evil I did dwel")).toBe(true);
            expect(isPalindrome("Lid off a daffodil")).toBe(true);
            expect(isPalindrome("Lived on decaf, faced no devil")).toBe(true);
            expect(isPalindrome("Lisa Bonet ate no basil")).toBe(true);
            expect(isPalindrome("Lonely Tylenol")).toBe(true);
            expect(isPalindrome("Madam, I'm Adam")).toBe(true);
            expect(isPalindrome("Ma is as selfless as I am")).toBe(true);
            expect(isPalindrome("May a moody baby doom a yam?")).toBe(true);
            expect(isPalindrome("Mr. Owl ate my metal worm")).toBe(true);
            expect(isPalindrome("Name now one man")).toBe(true);
            expect(isPalindrome("Name no one man")).toBe(true);
            expect(isPalindrome("Naomi, I moan")).toBe(true);
            expect(isPalindrome("Naomi, did I moan?")).toBe(true);
            expect(isPalindrome("Naomi, sex at noon taxes I moan.")).toBe(true);
            expect(isPalindrome("Never odd or even")).toBe(true);
            expect(isPalindrome("No lemons, no melon")).toBe(true);
            expect(isPalindrome("No lemon, no melon")).toBe(true);
            expect(isPalindrome("No one made killer apparel like Dame Noon.")).toBe(true);
            expect(isPalindrome("No devil lived on")).toBe(true);
            expect(isPalindrome("Not a banana baton")).toBe(true);
            expect(isPalindrome("Now I see bees, I won")).toBe(true);
            expect(isPalindrome("No X in Nixon")).toBe(true);
            expect(isPalindrome("No X in Mr. R. M. Nixon")).toBe(true);
            expect(isPalindrome("Nurse, I spy gypsies, run!")).toBe(true);
            expect(isPalindrome("O Geronimo, no minor ego")).toBe(true);
            expect(isPalindrome("Oh no! Don Ho!")).toBe(true);
            expect(isPalindrome("Oozy rat in a sanitary zoo")).toBe(true);
            expect(isPalindrome("O, stone, be not so")).toBe(true);
            expect(isPalindrome("Pa's a sap")).toBe(true);
            expect(isPalindrome("Pull up if I pull up.")).toBe(true);
            expect(isPalindrome("Race car")).toBe(true);
            expect(isPalindrome("Race fast, safe car")).toBe(true);
            expect(isPalindrome("Rats live on no evil star")).toBe(true);
            expect(isPalindrome("Rise to vote, sir")).toBe(true);
            expect(isPalindrome("Satan, oscillate my metallic sonatas.")).toBe(true);
            expect(isPalindrome("Senile felines")).toBe(true);
            expect(isPalindrome("Sir, I'm Iris")).toBe(true);
            expect(isPalindrome("Sit on a potato pan, Otis!")).toBe(true);
            expect(isPalindrome("Step on no pets")).toBe(true);
            expect(isPalindrome("Stop pots")).toBe(true);
            expect(isPalindrome("Swap God for a janitor; rot in a jar of dog paws.")).toBe(true);
            expect(isPalindrome("T. Eliot, top bard, notes putrid tang emanating, is sad; I'd assign it a name: gnat dirt upset on drab pot toilet.")).toBe(true);
            expect(isPalindrome("Too bad I hid a boot")).toBe(true);
            expect(isPalindrome("Too hot to hoot")).toBe(true);
            expect(isPalindrome("UFO tofu")).toBe(true);
            expect(isPalindrome("Warsaw was raw")).toBe(true);
            expect(isPalindrome("Was it a cat I saw")).toBe(true);
            expect(isPalindrome("Was it a car or a cat I saw?")).toBe(true);
            expect(isPalindrome("We panic in a pew")).toBe(true);
            expect(isPalindrome("Won't lovers revolt now?")).toBe(true);
            expect(isPalindrome("Zeus sees Suez")).toBe(true);
            expect(isPalindrome("Zeus saw 'twas Suez")).toBe(true);
        })
    }
)
