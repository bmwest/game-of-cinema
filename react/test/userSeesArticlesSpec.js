import ArticleList from '../src/components/ArticleList';

describe('Article Index', () => {
  let wrapper;

  beforeEach(() => {
    spyOn(global, 'fetch').and.returnValue(
      createResponseFromFixture('articles/articleIndex'),
    );
  });

  afterEach(() => {
    wrapper.unmount();
  });

  describe('visiting the homepage', () => {
    beforeEach(() => {
      wrapper = mount(
        <ArticleList />
      );
    });

    it('has the article', done => {
      setTimeout(() => {
        let pageText = wrapper.text();
        expect(pageText).toContain('The 9 New Directors You Need to Watch')
        expect(pageText).toContain('By MANOHLA DARGIS and A.O. SCOTT')
        expect(pageText).toContain("The New Directors/New Film Series opens on Wednesday with the joyful “Patti Cake$,” one of several features by talented but little-known artists.")
        done();
      },0);
    });
  });
});
