import TheaterList from '../src/components/TheaterList';

describe('Theaters Index', () => {
  let wrapper;

  beforeEach(() => {
    spyOn(global, 'fetch').and.returnValue(
      createResponseFromFixture('theaters/theatersIndex'),
    );
  });

  afterEach(() => {
    wrapper.unmount();
  });

  describe('visiting the theaters homepage', () => {
    beforeEach(() => {
      wrapper = mount(
        <TheaterList />
      );
    });

    it('has the theaters', done => {
      setTimeout(() => {
        let pageText = wrapper.text();
        expect(pageText).toMatch('test theater1');
        expect(pageText).toMatch('test theater2');
        done();
      },0);
    });
  });
});
