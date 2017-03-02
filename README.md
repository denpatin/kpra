# Kinopoisk Review Analysis

**KPRA** is an experimental service to reduce tons of letters in film reviews
to quicklier grasp the films' essence and answer the two questions:

- Why _should_ I watch the film?
- Why should _not_ I watch the film?

## Development Process Outline

- [ ] Find the location (in HTML) of the numbers that indicate how many
positive/negative/neutral reviews there are, and extract them.
- [ ] Depending of the above numbers, calculate the maximum number of reviews
per page to display (in order to minimize the number of pages to download and
parse).
- [ ] Write a script to download all the reviews (and, perhaps, store them
temporary locally).
- [ ] Bring all words to the initial form in order to compute `tf–idf`. For
example, via Yandex'es `mystem`.
- [ ] Compute the `tf–idf` statistic on the obtained data. Presumably the
better way is to treat the primary data as follows: Each review is a
_document_, each collection of reviews according to some mood is a
_collection_, or _corpus_. However note that since it's important to know the
word weight for a certain mood, there's probably good logic in treating the
whole set of reviews (independent from the mood) as a single corpus as well.
- [ ] Define collocations by using `t-test`, `chi-square`, `MLE`, `MI`/`PMI`,
etc. As well as above, maybe it's needed to work on the initial word forms.
After obtaining various metrics, opt for the most appropriate (basing on some
factors?) collocations.
- [ ] Develop a simple GUI for a web service.

## Plans For the Future

* KPRA should function as a separate web service that enables users to promptly
check the info about the film.
* KPRA should somehow retain the already collected information for the quicker
processing of further requests.
