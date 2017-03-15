import ArticleList from '../src/components/ArticleList';

describe('Article Index', () => {
  let wrapper;

  beforeEach(() => {
    spyOn(global, 'fetch').and.returnValue(
      createResponseFromFixture('articles/ArticleIndex')
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
      console.log(wrapper.text())
      setTimeout(() => {
        let pageText = wrapper.text();
        expect(pageText).toMatch('Kong: Skull Island');
        done();
      },0);
    });
  });
});
